#pragma once

#include "transmittercontroller.h"
#include "transmittersstate.h"

#include <QList>
#include <QObject>
#include <QQmlListProperty>

class TransmitterManager : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(TransmitterManager)

    Q_PROPERTY(QQmlListProperty<TransmitterController> transmitterControllers READ qmlTransmitterControllers)
    Q_PROPERTY(int transmittersState READ transmittersState NOTIFY transmittersStateChanged STORED false)

public:
    TransmitterManager();

    bool addTransmitterController(TransmitterController *controller);
    Q_INVOKABLE TransmitterController *getTransmitterController(int id) const;
    const QList<TransmitterController *> &transmitterControllers() const { return m_controllers; }

    int transmittersState() const { return m_transmittersState; }

signals:
    void transmittersStateChanged(TransmittersState::Value previousValue);

private:
    QQmlListProperty<TransmitterController> qmlTransmitterControllers();

private slots:
    void utilizationChanged(int previous, int current);

private:
    QList<TransmitterController *> m_controllers;
    TransmittersState::Value m_transmittersState;
};
