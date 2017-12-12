#include "daemonconnection.h"

#include <QByteArray>
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

bool DaemonConnection::setTransmitterUtilization(int transmitterId, int utilization)
{
    if (static_cast<unsigned>(transmitterId) > 0xFF || static_cast<unsigned>(utilization) > 0xFF)
        return false;

    // Construct message.
    QByteArray message;

    message.append(static_cast<char>(0)); // Version.
    message.append(static_cast<char>(1)); // Method ID.
    message.append(static_cast<char>(0)); // Message Type.
    message.append(static_cast<char>(0)); // Reserved.
    message.append(static_cast<char>(transmitterId));
    message.append(static_cast<char>(utilization));
    message.append(static_cast<char>(0)); // Reserved.
    message.append(static_cast<char>(0)); // Reserved.

    // Send message.
    if (m_socket.write(message) == -1) {
        qWarning("Failed to send message to daemon: %s", qUtf8Printable(m_socket.errorString()));
        return false;
    }

    m_socket.waitForBytesWritten();
    m_socket.waitForReadyRead();

    // Read response.
    message = m_socket.read(256);

    if (message.length() < 4) {
        qWarning("Daemon return an invalid data");
        return false;
    }

    if (message.at(2) != 1) {
        qWarning("Failed to set transmitter utilization");
        return false;
    }

    return true;
}
