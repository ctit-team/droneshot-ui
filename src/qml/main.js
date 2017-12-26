function setTransmittersUtilization(value) {
    var controllers = transmitterManager.transmitterControllers;
    for (var i = 0; i < controllers.length; i++) {
        controllers[i].utilization = value
    }
}
