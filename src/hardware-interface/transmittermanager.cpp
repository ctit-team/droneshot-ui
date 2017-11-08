#include "transmittermanager.h"

TransmitterManager::TransmitterManager()
{
}

bool TransmitterManager::addTransmitterController(TransmitterController *controller)
{
    int id = controller->id();

    // Check existing.
    if (getTransmitterController(id)) {
        return false;
    }

    // Add to collection.
    m_controllers.append(controller);
    controller->setParent(this);

    return true;
}

TransmitterController *TransmitterManager::getTransmitterController(int id) const
{
    for (int i = 0; i < m_controllers.size(); i++) {
        TransmitterController *controller = m_controllers.at(i);
        if (controller->id() != id) {
            continue;
        }

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
