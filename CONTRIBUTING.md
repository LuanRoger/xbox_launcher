# Contribuition Guideline
Thanks to be intresting in contribute with the porject. This Guide will assume that you know [Git](https://git-scm.com) and know the GitHub workflow. If you want to know more, see this [firstcontributions's repo](https://github.com/firstcontributions/first-contributions).
This Guideline will show how the project is currently working and explain the arcthecture to be easier to contribute to.

We are always needing help to:

- See the open issues.
- We still don't have a logo or visual identity.
- Improve the design of pages or widgets.
- Improve the code architecture.
- Improve performance and decrease memory consumption (memory leak).

You can contribute to the project it self, scripts or visual identity.

# Folder Structure

## root
![folder_structure](https://user-images.githubusercontent.com/46284513/193261152-25381296-fac9-4539-ae41-b76840dd6285.png)


- **assets**: Images and fonts useed in the project.
- **images**: Screenshots useed in the README.
- **lib**: The project code it self.
- **tools**: The scripts useed to get informations consumed by the xbox_launcher.

## lib
![lib_structure](https://user-images.githubusercontent.com/46284513/193261722-37c4f64d-0d9b-4103-8b3b-7f2016a60e67.png)

- **controllers**: The controllers/services used globaly on the xbox_launcher, like file picker, keyboard and controller inputs manager and the xbox_launcher's System Apps information.
- **models**: The object models, the JSON serialization/deserialization are made on the respectly model. Here satay the models of the providers (including the profile's preferences models), patterns, Games and Apps.
- **pages**: The pages's interface code are here, including the navigation sections and exclusive widget (used only in that page).
- **providers**: The project use [provider](https://pub.dev/packages/provider) to manage the controller and keyboard keybinding and the profile information, the [profile_provider](https://github.com/LuanRoger/xbox_launcher/blob/main/lib/providers/profile_provider.dart) uses [shared_preferences](https://pub.dev/packages/shared_preferences) to get the last used profile by the id and load it with [profile_loader](https://github.com/LuanRoger/xbox_launcher/blob/main/lib/utils/loaders/profile_loader.dart). 
  - The ProfileModel is private, so every propertie that must to be public need to have a Getter and Setter, the setter need to call ```notifyListeners()``` and ```saveProfile()```, if the change affect all profiles or add/remove a profile, is recommended to call ```saveProfiles()``` to save the changes for all profiles.
- **routes**: Here is the routes for every page in the xbox_launcher.
- **shared**: The enums, app's constants (colors, directories, images from assets) and all the own widgets are here. Some widgets here are based on the [fluent_ui](https://github.com/bdlukaa/fluent_ui) widgets.

# Code style guide
It's important to made a readable code, so before to send a pull request check the code style.

## Dart (xbox_launcher's code)

This code fallow the [Effective Dart: Style](https://dart.dev/guides/language/effective-dart/style).
But some exceptions are applyed to this project:
- If the ```if``` statment have only one instruction, the curly braces must to be ignored. Add 
  ```dart
  // ignore_for_file: curly_braces_in_flow_control_structures
  ```
  on the top of the file.
- The name of constants (```const```) must to be in uppercase:
  ```dart
  //Add this line on the top of the file.
  // ignore_for_file: constant_identifier_names
  
  static const Color DARK_BG = Color.fromRGBO(40, 39, 41, 1);
  ```
  
Any thing else there is not in the exceptions need to fallow the [Effective Dart: Style](https://dart.dev/guides/language/effective-dart/style).

## Script code
The Python's script must to fallow the [PEP 8](https://peps.python.org/pep-0008) style.

## Remarks
Some parts of the code don't fallow the convetions mentioned above, so fell free to format the code.
