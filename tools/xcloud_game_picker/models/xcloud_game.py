import json
from turtle import title


class XcloudGame:
    gameTitle: str
    gamePublisher: str
    xcloudUrl: str
    gameImageUrl: str

    def __init__(self, gameTitle: str, gamePublisher:str, xcloudUrl: str, gameImageUrl: str):
        self.gameTitle = gameTitle
        self.gamePublisher = gamePublisher
        self.xcloudUrl = xcloudUrl
        self.gameImageUrl = gameImageUrl