#pragma once

#include "transmittercontroller.h"

#include <QList>
#include <QObject>
#include <QQmlListProperty>

class TransmitterManager : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(TransmitterManager)

    Q_PROPERTY(QQmlListProperty<TransmitterController> transmitterControllers READ qmlTransmitterControllers)

public:
    TransmitterManager();

    bool addTransmitterController(TransmitterController *controller);
    Q_INVOKABLE TransmitterController *getTransmitterController(int id) const;
    const QList<TransmitterController *> &transmitterControllers() const { return m_controllers; }

private:
    QQmlListProperty<TransmitterController> qmlTransmitterControllers();

    QList<TransmitterController *> m_controllers;
};
