#pragma once

#include <QObject>

class TransmitterController : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(TransmitterController)

    Q_PROPERTY(int id READ id CONSTANT)
    Q_PROPERTY(int utilization READ utilization WRITE setUtilization NOTIFY utilizationChanged STORED false)

public:
    TransmitterController(int id);

    int id() const { return m_id; }

    void setUtilization(int value);
    int utilization();

signals:
    void utilizationChanged(int previous, int current);

private:
    int m_id;
};
