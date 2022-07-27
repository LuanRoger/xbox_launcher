from attr import has


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

    def __eq__(self, other: object) -> bool:
        if(isinstance(other, type(self))):
            return self.gameTitle == other.gameTitle
        return False
    def __repr__(self) -> str:
        return f"Game({self.gameTitle})"
    def __hash__(self) -> int:
        return hash(self.__repr__())