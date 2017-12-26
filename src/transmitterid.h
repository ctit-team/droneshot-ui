#pragma once

#include <QObject>

namespace TransmitterID {

Q_NAMESPACE

enum Value
{
    Unknown,
    WiFi1, // 2.4 - 2.5 lower
    WiFi2, // 2.4 - 2.5 upper
    WiFi3, // 5.5 - 5.8
    GPS,   // 1575
    RC1,   // 868 - 912
    RC2    // 433 - 434
};

Q_ENUM_NS(Value)

}
