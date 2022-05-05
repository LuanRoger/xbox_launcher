class GameModel {
  String gameTitle;
  String xcloudUrl;
  String imageUrl;

  GameModel(this.gameTitle, this.xcloudUrl, this.imageUrl);
  GameModel.fromJson(Map<int, dynamic> jsonObject)
      : gameTitle = jsonObject["gameTitle"],
        xcloudUrl = jsonObject["xcloudUrl"],
        imageUrl = jsonObject["imageUrl"];

  Map<String, dynamic> toJson() => {
        "gameTitle": gameTitle,
        "xcloudUrl": xcloudUrl,
      };
}