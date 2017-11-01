#pragma once

#include "transmittercontroller.h"

#include <QList>
#include <QObject>
#include <QSharedPointer>

class TransmitterManager : public QObject
{
    Q_OBJECT

public:
    explicit TransmitterManager(const QList<QSharedPointer<TransmitterController>> &controllers);

private:
    Q_DISABLE_COPY(TransmitterManager)
};
