#include "transmittermanager.h"

TransmitterManager::TransmitterManager()
{
}

bool TransmitterManager::addTransmitterController(TransmitterController *controller)
{
    int id = controller->id();

    // Check existing.
    if (m_controllers.count(id)) {
        return false;
    }

    // Add to collection.
    m_controllers.insert(id, controller);
    controller->setParent(this);

    return true;
}

TransmitterController *TransmitterManager::getTransmitterController(int id)
{
    auto i = m_controllers.find(id);
    if (i == m_controllers.end()) {
        return nullptr;
    }

    return i.value();
}
