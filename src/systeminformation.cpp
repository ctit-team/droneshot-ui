#include "systeminformation.h"

#include <QStorageInfo>

#ifdef Q_OS_LINUX
#include <sys/sysinfo.h>
#endif

#define KB(b) ((b) / 1024)
#define MB(b) (KB(b) / 1024)
#define GB(b) (MB(b) / 1024)

#define updateProperty(p) \
    if (m_##p != p) { \
        auto previous = m_##p; \
        m_##p = p; \
        emit p##Changed(previous); \
    }

SystemInformation::SystemInformation(QObject *parent) :
    QObject(parent),
    m_ip("192.168.50.100")
{
    // Initializes Information.
    update();

    // Setup Timer to update information.
    connect(&m_updater, SIGNAL(timeout()), SLOT(update()));
    m_updater.start(1 * 1000);
}

void SystemInformation::update()
{
    // Get Storage Information.
    QStorageInfo storageInfo = QStorageInfo::root();

    QString availableStorage = QString::number(GB(storageInfo.bytesFree())) + " GB";
    QString totalStorage = QString::number(GB(storageInfo.bytesTotal())) + " GB";

    // Get Memory Information.
    QString availableMemory, totalMemory, uptime;

#ifdef Q_OS_LINUX
    struct sysinfo systemInfo;

    if (sysinfo(&systemInfo) != -1) {
        availableMemory = QString::number(MB(systemInfo.freeram)) + " MB";
        totalMemory = QString::number(MB(systemInfo.totalram)) + " MB";

        // Calculate Uptime.
        auto seconds = systemInfo.uptime;
        auto days = seconds / 86400; seconds %= 86400;
        auto hours = seconds / 3600; seconds %= 3600;
        auto minutes = seconds / 60; seconds %= 60;
        uptime.sprintf("%ld:%02ld:%02ld:%02ld", days, hours, minutes, seconds);
    } else
#endif
    {
        availableMemory = "Unknown";
        totalMemory = "Unknown";
        uptime = "Unknown";
    }

    // Update.
    updateProperty(availableStorage)
    updateProperty(totalStorage)
    updateProperty(availableMemory)
    updateProperty(totalMemory)
    updateProperty(uptime)
}
