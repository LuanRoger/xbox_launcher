class GameModel {
  String gameTitle;
  String xcloudUrl;
  String tileImageUrl;
  String gameImageUrl;

  GameModel(
      this.gameTitle, this.xcloudUrl, this.tileImageUrl, this.gameImageUrl);
  GameModel.fromJson(Map<int, dynamic> jsonObject)
      : gameTitle = jsonObject["gameTitle"],
        xcloudUrl = jsonObject["xcloudUrl"],
        tileImageUrl = jsonObject["tileImageUrl"],
        gameImageUrl = jsonObject["gameImageUrl"];

  Map<String, dynamic> toJson() => {
        "gameTitle": gameTitle,
        "xcloudUrl": xcloudUrl,
        "tileImageUrl": tileImageUrl,
        "gameImageUrl": gameImageUrl
      };
}
