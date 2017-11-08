#include "transmittercontroller.h"

TransmitterController::TransmitterController(int id) :
    m_id(id),
    m_util(0)
{
}

void TransmitterController::setUtilization(int value)
{
    if (value < 0 || value > 100) {
        return;
    }

    int prev = m_util;
    m_util = value;

    emit utilizationChanged(prev, m_util);
}

int TransmitterController::utilization()
{
    return m_util;
}
