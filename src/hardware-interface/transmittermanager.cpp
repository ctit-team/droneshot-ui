#include "transmittermanager.h"

TransmitterManager::TransmitterManager() :
    m_transmittersState(TransmittersState::AllOff)
{
}

bool TransmitterManager::addTransmitterController(TransmitterController *controller)
{
    int id = controller->id();

    // Check existing.
    if (controller->utilization() || getTransmitterController(id)) {
        return false;
    }

    // Add to collection.
    connect(controller, SIGNAL(utilizationChanged(int,int)), SLOT(utilizationChanged(int,int)));

    m_controllers.append(controller);
    controller->setParent(this);

    return true;
}

TransmitterController *TransmitterManager::getTransmitterController(int id) const
{
    foreach (TransmitterController *controller, m_controllers) {
        if (controller->id() != id)
            continue;

        // No need to mark C++ ownership since the current class is it's parent.
        return controller;
    }

    return nullptr;
}

QQmlListProperty<TransmitterController> TransmitterManager::qmlTransmitterControllers()
{
    auto count = [](QQmlListProperty<TransmitterController> *list) -> int
    {
        return reinterpret_cast<TransmitterManager *>(list->data)->m_controllers.size();
    };

    auto at = [](QQmlListProperty<TransmitterController> *list, int index) -> TransmitterController *
    {
        return reinterpret_cast<TransmitterManager *>(list->data)->m_controllers.at(index);
    };

    return QQmlListProperty<TransmitterController>(this, this, count, at);
}

void TransmitterManager::utilizationChanged(int previous, int current)
{
    Q_UNUSED(previous);
    Q_UNUSED(current);

    // Count how many on.
    int onCount = 0;

    foreach (TransmitterController *controller, m_controllers) {
        if (controller->utilization())
            onCount++;
    }

    // Calculate State.
    TransmittersState::Value newState;

    if (!onCount)
        newState = TransmittersState::AllOff;
    else if (onCount == m_controllers.size())
        newState = TransmittersState::AllOn;
    else
        newState = TransmittersState::AtLeastOneOn;

    // Update Property.
    if (newState != m_transmittersState) {
        TransmittersState::Value previousState = m_transmittersState;
        m_transmittersState = newState;
        emit transmittersStateChanged(previousState);
    }
}
