import json
from typing import List

from .game_properties import GameProperties

class XcloudGame:
    gameTitle: str
    gamePublisher: str
    gameDeveloper: str
    gameGenres: List[str]
    releaseDate: str
    extraGameProperties: GameProperties
    xcloudUrl: str
    tileGameImageUrl: str
    gameImageUrl: str
    storeUrl: str

    def __init__(self, gameTitle: str, gamePublisher:str, gameDeveloper: str, gameGenres: List[str],
     releaseDate: str, extraGameProperties: GameProperties, xcloudUrl: str, tileGameImageUrl: str, gameImageUrl: str, 
     storeUrl: str):
        self.gameTitle = gameTitle
        self.gamePublisher = gamePublisher
        self.gameDeveloper = gameDeveloper
        self.gameGenres = gameGenres
        self.releaseDate = releaseDate
        self.extraGameProperties = extraGameProperties
        self.xcloudUrl = xcloudUrl
        self.tileGameImageUrl = tileGameImageUrl
        self.gameImageUrl = gameImageUrl
        self.storeUrl = storeUrl

    def __eq__(self, other: object) -> bool:
        if(isinstance(other, type(self))):
            return self.gameTitle == other.gameTitle
        return False
    def __repr__(self) -> str:
        return f"Game({self.gameTitle})"
    def __hash__(self) -> int:
        return hash(self.__repr__())
    def __iter__(self):
        yield from {
            "gameTitle": self.gameTitle,
            "gamePublisher": self.gamePublisher,
            "gameDeveloper": self.gameDeveloper,
            "gameGenres": self.gameGenres,
            "releaseDate": self.releaseDate,
            "extraGameProperties": dict(self.extraGameProperties),
            "xcloudUrl": self.xcloudUrl,
            "tileGameImageUrl": self.tileGameImageUrl,
            "gameImageUrl": self.gameImageUrl,
            "storeUrl": self.storeUrl
        }.items()

    def toJson(self):
        json.dumps(dict(self), sort_keys=True, indent=4)