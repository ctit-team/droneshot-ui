function turnOffAllTransmitters() {
    var controllers = transmitterManager.transmitterControllers;
    for (var i = 0; i < controllers.length; i++) {
        controllers[i].utilization = 0
    }
}
