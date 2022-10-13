import 'package:xbox_launcher/shared/enums/tile_size.dart';

class ProfilePreviewElementsPreferences {
  TileSize myLibraryTileSize;

  ProfilePreviewElementsPreferences({this.myLibraryTileSize = TileSize.MEDIUM});
  factory ProfilePreviewElementsPreferences.fromJson(
          Map<String, dynamic> json) =>
      ProfilePreviewElementsPreferences(
          myLibraryTileSize: TileSize.values[json["myLibraryTileSize"]]);

  Map<String, dynamic> toJson() =>
      {"myLibraryTileSize": myLibraryTileSize.index};
}
