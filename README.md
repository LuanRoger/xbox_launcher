# xbox_launcher

Launcher with the Xbox Series X/S's dashboard to play Xbox Cloud Gaming (XCloud) games.

[![fluent_desing](https://img.shields.io/badge/fluent-design-blue?style=flat-square&color=gray&labelColor=0078D7)](https://github.com/bdlukaa/fluent_ui)
[![license](https://img.shields.io/github/license/LuanRoger/xbox_launcher)](https://github.com/LuanRoger/xbox_launcher/blob/main/LICENCE.md)
![issues](https://img.shields.io/github/issues/LuanRoger/xbox_launcher)
![releases](https://img.shields.io/github/v/release/LuanRoger/xbox_launcher?include_prereleases)
[![Discuss on GitHub](https://img.shields.io/badge/GitHub-Discussions-333333?logo=github)](https://github.com/LuanRoger/xbox_launcher/discussions)

<p align="center">
  <img src="https://github.com/LuanRoger/xbox_launcher/blob/main/images/screenshot_home.png"/>
</p>

### 🚧 The project is current in development (Alpha phase) so it can be unstable and occurs errors commonly. 🚧

# Features
- Play Xbox Cloud Gaming (XCloud) directly from the launcher;
- Change the background from Home to a image, gif or solid color;
- Change the accent color;
- Create a profile, with your own cofiguration sets;
- Modify a existing profile with a new avatar or name;
- Set a image or gif as avatar image;
- Change the xbox.com/play region easely in the configurations;
- Fullscreen support;

## Dependencies
- [fluent_ui](https://github.com/bdlukaa/fluent_ui).
- [webview-windows](https://github.com/jnschulze/flutter-webview-windows).
- [provider](https://github.com/rrousselGit/provider).
- [xinput_gamepad](https://github.com/LuanRoger/xinput_gamepad) (First-party).
- [virtual_keyboard](https://github.com/LuanRoger/virtual_keyboard) (First-party).
- [clock](https://github.com/dart-lang/clock).
- [window_manager](https://github.com/leanflutter/window_manager).
- [shared_preferences](https://github.com/flutter/plugins/tree/main/packages/shared_preferences/shared_preferences).
- [file_picker](https://github.com/miguelpruivo/flutter_file_picker).
- [sprintf](https://github.com/Naddiseo/dart-sprintf).
- [carousel_slider](https://github.com/serenader2014/flutter_carousel_slider).
- [path_provider](https://github.com/flutter/plugins/tree/main/packages/path_provider/path_provider).
- [flutter_svg](https://github.com/dnfield/flutter_svg).

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

The Python 3.10, Microsoft Edge WebDriver and Selenium is required to get the games from [xbox.com/play](http://xbox.com/play), but you can use [xcloud_games.json](https://github.com/LuanRoger/xbox_launcher/blob/main/tools/xcloud_game_picker/xcloud_games.json) that have some games on it. This file is not updated regularly, so some games that are on Xbox Cloud Gaming may not be there.

### 1. Get the games
Go to ```.\tools\xcloud_game_picker\``` and execute the file ```xcloud_game_picker.py```:
```powershell
python .\xcloud_game_picker.py
```
and the Selenium will start to get the games, is important that you dont use the opened browser while dont finish.
### 2. Runing xbox_launcher
Go to root of the project and run on terminal:
```powershell
flutter run --release
```

> For now, not exist binaries or installers to use, so you need to build on its own.

### 3. Configuring
On xbox_launcher's Home page go to ```My Games > Apps > Configurations > Cloud gaming``` in the ```JSON file path``` field you paste the path to your xcloud_games.json file and confirm the changes.

# Screenshots
![home_page](https://github.com/LuanRoger/xbox_launcher/blob/main/images/screenshot_home.png)
_Home Page._

![profile_selector](https://github.com/LuanRoger/xbox_launcher/blob/main/images/screenshot_profiles.png)
_Profile Selector._

# Contribute
The project is in Alpha phase, therefore it is important that you consider contributing to the project in your spare time. Open an issue, pull request or engage in discussions to make the project better.

We are always needing help to:
- See the open issues.
- We still don't have a logo or visual identity.
- Improve the design of pages or widgets.
- Improve the code architecture.
- Improve performance and decrease memory consumption (memory leak).

For more info check the [Contribuition Guideline](https://github.com/LuanRoger/xbox_launcher/blob/main/CONTRIBUTING.md).

## Contribute to used packages
This project uses first-party and third-party open-source packages, so consider contributing to those as well.

[Go to dependencies](https://github.com/LuanRoger/xbox_launcher#dependencies).
