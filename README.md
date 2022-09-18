# xbox_launcher
Launcher with the Xbox Series X/S's dashboard to play Xbox Cloud Gaming (XCloud) games.

[![fluent_desing](https://img.shields.io/badge/fluent-design-blue?style=flat-square&color=gray&labelColor=0078D7)](https://github.com/bdlukaa/fluent_ui)
![issues](https://img.shields.io/github/issues/LuanRoger/xbox_launcher)
![releases](https://img.shields.io/github/v/release/LuanRoger/xbox_launcher?include_prereleases)
[![Discuss on GitHub](https://img.shields.io/badge/GitHub-Discussions-333333?logo=github)](https://github.com/LuanRoger/xbox_launcher/discussions)

### 🚧 The project is current in development (Alpha phase) so it can be unstable and occurs errors commonly. 🚧

# Features
- Play Xbox Cloud Gaming (XCloud) directly from the launcher;
- Change the background from Home to a image, gif or solid color;
- Change the accent color;
- Create a profile, with your own cofiguration sets;
- Modify a existing profile with a new avatar or name;
- Set a image or gif to the image avatar;
- Change the xbox.com/play region easely in the configurations;
- Fullscreen support;

# Setup
## Pre-requires
- A Xbox Game Pass Ultimate subscription
- Flutter 3.0+
- [WebView2 Runtime](https://developer.microsoft.com/en-us/microsoft-edge/webview2)
- Windows 10 1809+
- UWP SDK with Visual Studio 2022
- Python 3.10
- [Microsoft Edge WebDriver](https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver)
- [Selenium Python](https://selenium-python.readthedocs.io/installation.html#installation)

The Python 3.10, Microsoft Edge WebDriver and Selenium is required to get the games from [xbox.com/play](http://xbox.com/play), but you can use [xcloud_games.json](https://github.com/LuanRoger/xbox_launcher/blob/main/tools/xcloud_game_picker/xcloud_games.json) that have some games on it. This file is not updated regularly, so some games that are on Xbox Cloud Gaming may not be here.

### 1. Get the games
Go to ```.\tools\xcloud_game_picker\``` and execute the file ```xcloud_game_picker.py``` with:
```powershell
python .\xcloud_game_picker.py
```
and the Selenim will start to get the games, is important that you dont use the opened browser while dont finish.
### 2. Runing xbox_launcher
Go to root of the project and run on terminal:
```powershell
flutter run --release
```

> For now, non exist bynaries or installers to use, so you need to build on its own.

### 3. Configuring
On xbox_launcher's Home page go to ```My Games > Apps > Configurations > Cloud gaming``` in the ```JSON file path``` field you paste the path to your xcloud_games.json file and confirm the changes.