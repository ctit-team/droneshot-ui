#pragma once

#include <QLocalSocket>
#include <QObject>

class DaemonConnection : public QObject
{
    Q_OBJECT
public:
    explicit DaemonConnection(QObject *parent = nullptr);

    bool connect(const QString &name);

private:
    QLocalSocket m_socket;
};
