#pragma once

#include <QObject>

class TransmitterController : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int utilization READ utilization WRITE setUtilization NOTIFY utilizationChanged)

public:
    TransmitterController();

    void setUtilization(int value);
    int utilization();

signals:
    void utilizationChanged(int previous, int current);

private:
    Q_DISABLE_COPY(TransmitterController)
};
