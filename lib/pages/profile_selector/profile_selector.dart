import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/models/profile_model.dart';
import 'package:xbox_launcher/pages/profile_selector/widgets/profile_selector_item.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/background.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateless.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class ProfileSelector extends XboxPageStateless {
  void Function(BuildContext, ProfileModel) onProfileSelect;

  late List<FocusNode> _sliderItemsFocusNodes;
  late Background _backgroundPreview;
  List<ProfileModel>? _profilesAvailable;

  late void Function(void Function()) _updateBackground;
  final CarouselController _profileSliderController = CarouselController();

  ProfileSelector({Key? key, required this.onProfileSelect}) : super(key: key) {
    keyAction = {
      ControllerKeyboardPair(
              LogicalKeyboardKey.escape, ControllerButton.B_BUTTON):
          ((context) => Navigator.pop(context)),
      ControllerKeyboardPair(
              LogicalKeyboardKey.arrowRight, ControllerButton.DPAD_RIGHT):
          (context) => _profileSliderController.nextPage(),
      ControllerKeyboardPair(
              LogicalKeyboardKey.arrowLeft, ControllerButton.DPAD_LEFT):
          (context) => _profileSliderController.previousPage()
    };

    _sliderItemsFocusNodes = List.empty(growable: true);
    _backgroundPreview = Background();
  }

  @override
  Widget virtualBuild(BuildContext context) {
    _profilesAvailable = context.read<ProfileProvider>().profilesList;

    return Stack(
      fit: StackFit.expand,
      children: [
        StatefulBuilder(builder: (_, setState) {
          _updateBackground = setState;
          return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: _backgroundPreview));
        }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Expanded(
                flex: 0,
                child: Text(
                  "Select the profile",
                  style: AppTextStyle.PROFILE_SELECTION_TITLE,
                ),
              ),
              Expanded(
                child: CarouselSlider(
                  items: _profilesAvailable!.map((profile) {
                    ProfileSelectorItem item = ProfileSelectorItem(
                      profileModel: profile,
                      onSelect: () {
                        onProfileSelect(context, profile);
                        Navigator.pop(context);
                      },
                    );
                    _sliderItemsFocusNodes.add(item.focusNode);
                    return item;
                  }).toList(),
                  options: CarouselOptions(
                      autoPlay: false,
                      disableCenter: true,
                      viewportFraction: 0.3,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, _) {
                        _sliderItemsFocusNodes[index].requestFocus();
                        _updateBackground(() => _backgroundPreview = Background(
                              profileModel: _profilesAvailable![index],
                            ));
                      }),
                  carouselController: _profileSliderController,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
