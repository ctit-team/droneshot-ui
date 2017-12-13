#include "daemonconnection.h"
#include "transmitterid.h"

#include <hardware-interface/transmittercontroller.h>
#include <hardware-interface/transmittermanager.h>

#include <QtGlobal>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static FILE *logFile;

static TransmitterController *createTransmitterController(int id, DaemonConnection *daemon)
{
    return new TransmitterController(id, daemon);
}

static bool registerTransmitterController(TransmitterManager &manager, TransmitterController *controller)
{
    if (!manager.addTransmitterController(controller)) {
        delete controller;
        return false;
    }

    return true;
}

static bool setUpTransmitterManager(TransmitterManager &manager, DaemonConnection &daemon)
{
    TransmitterController *controller;

    // WiFi 1.
    controller = createTransmitterController(TransmitterID::WiFi1, &daemon);
    if (!controller || !registerTransmitterController(manager, controller)) {
        return false;
    }

    // WiFi 2.
    controller = createTransmitterController(TransmitterID::WiFi2, &daemon);
    if (!controller || !registerTransmitterController(manager, controller)) {
        return false;
    }

    // WiFi 3.
    controller = createTransmitterController(TransmitterID::WiFi3, &daemon);
    if (!controller || !registerTransmitterController(manager, controller)) {
        return false;
    }

    // GPS.
    controller = createTransmitterController(TransmitterID::GPS, &daemon);
    if (!controller || !registerTransmitterController(manager, controller)) {
        return false;
    }

    // RC 1.
    controller = createTransmitterController(TransmitterID::RC1, &daemon);
    if (!controller || !registerTransmitterController(manager, controller)) {
        return false;
    }

    // RC 2.
    controller = createTransmitterController(TransmitterID::RC2, &daemon);
    if (!controller || !registerTransmitterController(manager, controller)) {
        return false;
    }

    return true;
}

static void registerQmlTypes()
{
    qmlRegisterUncreatableType<TransmitterController>("Hardware.Transmitter", 1, 0, "TransmitterController", "Can instantiate from C++ only");

    qmlRegisterUncreatableMetaObject(TransmitterID::staticMetaObject, "Hardware.Transmitter", 1, 0, "TransmitterID", "Access to enum only");
}

static void logMessageHandler(QtMsgType type, const QMessageLogContext &context, const QString &message)
{
    Q_UNUSED(context);

    fprintf(logFile, "%s\n", message.toLocal8Bit().constData());

    if (type == QtFatalMsg)
        abort();
}

static void setUpLogging(void)
{
    // Get file name.
    auto fileName = QString::fromLocal8Bit(qgetenv("DRONESHOT_UI_LOGFILE"));
    if (fileName.isEmpty())
        return;

    // Open file.
    logFile = fopen(fileName.toLocal8Bit().constData(), "a");
    if (!logFile) {
        auto errorCode = errno;
        qWarning("Failed to open %s for logging: %s", qUtf8Printable(fileName), strerror(errorCode));
        return;
    }

    // Install Handler.
    qInstallMessageHandler(logMessageHandler);
}

int main(int argc, char *argv[])
{
    // Setup Application.
    setUpLogging();
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    // Initialize Application.
    QGuiApplication app(argc, argv);

    DaemonConnection daemonConnection;
    if (!daemonConnection.connect("/tmp/droneshot"))
        return -1;

    TransmitterManager transmitterManager;
    if (!setUpTransmitterManager(transmitterManager, daemonConnection))
        return -1;

    registerQmlTypes();

    // Setup QML.
    QQmlApplicationEngine engine;

    engine.addImportPath("qrc:/qml/modules/");

    engine.rootContext()->setContextProperty("transmitterManager", &transmitterManager);

    engine.load(QUrl(QLatin1String("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    // Enter main loop.
    return app.exec();
}
