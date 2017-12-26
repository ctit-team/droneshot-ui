#pragma once

#include <QObject>

namespace TransmittersState {

Q_NAMESPACE

enum Value {
    AllOff,
    AllOn,
    AtLeastOneOn
};

Q_ENUM_NS(Value)

}
