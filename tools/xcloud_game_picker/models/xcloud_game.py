class XcloudGame:
    gameTitle: str
    gamePublisher: str
    xcloudUrl: str
    tileGameImageUrl: str
    gameImageUrl: str

    def __init__(self, gameTitle: str, gamePublisher:str, xcloudUrl: str, tileGameImageUrl: str, gameImageUrl: str):
        self.gameTitle = gameTitle
        self.gamePublisher = gamePublisher
        self.xcloudUrl = xcloudUrl
        self.tileGameImageUrl = tileGameImageUrl
        self.gameImageUrl = gameImageUrl