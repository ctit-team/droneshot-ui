#include "transmitterid.h"

#include <hardware-interface/transmittercontroller.h>
#include <hardware-interface/transmittermanager.h>

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

static TransmitterController *createWiFi1TransmitterController()
{
    return new TransmitterController(TransmitterID::WiFi1);
}

static TransmitterController *createWiFi2TransmitterController()
{
    return new TransmitterController(TransmitterID::WiFi2);
}

static TransmitterController *createWiFi3TransmitterController()
{
    return new TransmitterController(TransmitterID::WiFi3);
}

static TransmitterController *creatGPSTransmitterController()
{
    return new TransmitterController(TransmitterID::GPS);
}

static TransmitterController *createRC1TransmitterController()
{
    return new TransmitterController(TransmitterID::RC1);
}

static TransmitterController *createRC2TransmitterController()
{
    return new TransmitterController(TransmitterID::RC2);
}

static bool registerTransmitterController(TransmitterManager &manager, TransmitterController *controller)
{
    if (!manager.addTransmitterController(controller)) {
        delete controller;
        return false;
    }

    return true;
}

static bool setUpTransmitterManager(TransmitterManager &manager)
{
    TransmitterController *controller;

    // WiFi 1.
    controller = createWiFi1TransmitterController();
    if (!controller || !registerTransmitterController(manager, controller)) {
        return false;
    }

    // WiFi 2.
    controller = createWiFi2TransmitterController();
    if (!controller || !registerTransmitterController(manager, controller)) {
        return false;
    }

    // WiFi 3.
    controller = createWiFi3TransmitterController();
    if (!controller || !registerTransmitterController(manager, controller)) {
        return false;
    }

    // GPS.
    controller = creatGPSTransmitterController();
    if (!controller || !registerTransmitterController(manager, controller)) {
        return false;
    }

    // RC 1.
    controller = createRC1TransmitterController();
    if (!controller || !registerTransmitterController(manager, controller)) {
        return false;
    }

    // RC 2.
    controller = createRC2TransmitterController();
    if (!controller || !registerTransmitterController(manager, controller)) {
        return false;
    }

    return true;
}

static void registerQmlTypes()
{
    qmlRegisterInterface<TransmitterController>("TransmitterController");

    qmlRegisterUncreatableMetaObject(TransmitterID::staticMetaObject, "Hardware.Transmitter", 1, 0, "TransmitterID", "Access to enum only");
}

int main(int argc, char *argv[])
{
    // Setup application.
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    TransmitterManager transmitterManager;
    setUpTransmitterManager(transmitterManager);

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
