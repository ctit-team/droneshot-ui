#pragma once

#include "transmittercontroller.h"

#include <QHash>
#include <QObject>

class TransmitterManager : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(TransmitterManager)

public:
    TransmitterManager();

    bool addTransmitterController(TransmitterController *controller);
    Q_INVOKABLE TransmitterController *getTransmitterController(int id);

private:
    QHash<int, TransmitterController *> m_controllers;
};
