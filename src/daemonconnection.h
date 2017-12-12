#pragma once

#include <QLocalSocket>
#include <QObject>

class DaemonConnection : public QObject
{
    Q_OBJECT
public:
    explicit DaemonConnection(QObject *parent = nullptr);

    bool connect(const QString &name);

    bool setTransmitterUtilization(int transmitterId, int utilization);

private:
    QLocalSocket m_socket;
};
