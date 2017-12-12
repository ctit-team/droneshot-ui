#include "transmittercontroller.h"

TransmitterController::TransmitterController(int id, DaemonConnection *daemon) :
    m_daemon(daemon),
    m_id(id),
    m_util(0)
{
}

void TransmitterController::setUtilization(int value)
{
    if (value < 0 || value > 100 || value == m_util)
        return;

    if (!m_daemon->setTransmitterUtilization(m_id, value))
        return;

    int prev = m_util;
    m_util = value;

    emit utilizationChanged(prev, m_util);
}

int TransmitterController::utilization()
{
    return m_util;
}
