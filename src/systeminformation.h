#pragma once

#include <QObject>
#include <QTimer>

class SystemInformation : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString availableMemory READ availableMemory NOTIFY availableMemoryChanged STORED false)
    Q_PROPERTY(QString availableStorage READ availableStorage NOTIFY availableStorageChanged STORED false)
    Q_PROPERTY(QString ipAddress READ ipAddress NOTIFY ipAddressChanged STORED false)
    Q_PROPERTY(QString totalMemory READ totalMemory NOTIFY totalMemoryChanged STORED false)
    Q_PROPERTY(QString totalStorage READ totalStorage NOTIFY totalStorageChanged STORED false)
    Q_PROPERTY(QString uptime READ uptime NOTIFY uptimeChanged STORED false)

public:
    explicit SystemInformation(QObject *parent = nullptr);

    const QString &availableMemory() const { return m_availableMemory; }
    const QString &availableStorage() const { return m_availableStorage; }
    const QString &ipAddress() const { return m_ip; }
    const QString &totalMemory() const { return m_totalMemory; }
    const QString &totalStorage() const { return m_totalStorage; }
    const QString &uptime() const { return m_uptime; }

signals:
    void availableMemoryChanged(const QString &previous);
    void availableStorageChanged(const QString &previous);
    void ipAddressChanged(const QString &previous);
    void totalMemoryChanged(const QString &previous);
    void totalStorageChanged(const QString &previous);
    void uptimeChanged(const QString &previous);

private slots:
    void update();

private:
    QTimer m_updater;

    QString m_availableMemory;
    QString m_availableStorage;
    QString m_ip;
    QString m_totalMemory;
    QString m_totalStorage;
    QString m_uptime;
};
