class GameProperties:
    isInGamePass: bool
    controllerSupport: bool
    touchControllerSupport: bool

    def __init__(self, isInGamePass: bool, 
    controllerSupport: bool,
    touchControllerSupport: bool):
        self.isInGamePass = isInGamePass
        self.controllerSupport = controllerSupport
        self.touchControllerSupport = touchControllerSupport
    
    def __iter__(self):
        yield from {
            "isInGamePass": self.isInGamePass,
            "controllerSupport": self.controllerSupport,
            "touchControllerSupport": self.touchControllerSupport
        }.items()