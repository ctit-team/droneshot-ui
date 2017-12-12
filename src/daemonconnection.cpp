#include "daemonconnection.h"

#include <QtGlobal>

#include <errno.h>
#include <string.h>

#include <unistd.h>
#include <sys/socket.h>
#include <sys/un.h>

static int connectToDaemon(const char *socketName)
{
    int fileDescriptor;
    sockaddr_un address;

    // Create socket.
    fileDescriptor = socket(AF_UNIX, SOCK_SEQPACKET, 0);
    if (fileDescriptor == -1) {
        int errorCode = errno;
        qCritical("Failed to create a socket for connect to daemon: %s", strerror(errorCode));
        return -1;
    }

    // Connect to daemon.
    memset(&address, 0, sizeof(address));
    address.sun_family = AF_UNIX;
    strcpy(address.sun_path, socketName);

    if (connect(fileDescriptor, reinterpret_cast<sockaddr *>(&address), sizeof(address)) == -1) {
        int errorCode = errno;
        close(fileDescriptor);
        qCritical("Failed to connect to daemon: %s", strerror(errorCode));
        return -1;
    }

    return fileDescriptor;
}

DaemonConnection::DaemonConnection(QObject *parent) :
    QObject(parent)
{
}

bool DaemonConnection::connect(const QString &name)
{
    auto fileDescriptor = connectToDaemon(name.toUtf8().data());
    if (fileDescriptor == -1)
        return false;

    if (!m_socket.setSocketDescriptor(fileDescriptor)) {
        close(fileDescriptor);
        qCritical("Failed to assign a socket to a connection");
        return false;
    }

    return true;
}
