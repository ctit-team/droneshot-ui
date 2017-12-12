#pragma once

#include "../daemonconnection.h"

#include <QObject>

class TransmitterController : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(TransmitterController)

    Q_PROPERTY(int id READ id CONSTANT)
    Q_PROPERTY(int utilization READ utilization WRITE setUtilization NOTIFY utilizationChanged STORED false)

public:
    TransmitterController(int id, DaemonConnection *daemon);

    int id() const { return m_id; }

    void setUtilization(int value);
    int utilization();

signals:
    void utilizationChanged(int previous, int current);

private:
    DaemonConnection *m_daemon;
    int m_id;
    int m_util;
};
