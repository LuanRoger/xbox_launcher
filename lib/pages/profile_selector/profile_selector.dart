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
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateful.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

//TODO: Made stateless
class ProfileSelector extends XboxPageStateful {
  CarouselController profileSliderController = CarouselController();

  ProfileSelector({Key? key}) : super(key: key) {
    keyAction = {
      ControllerKeyboardPair(
              LogicalKeyboardKey.escape, ControllerButton.B_BUTTON):
          ((context) => Navigator.pop(context)),
      ControllerKeyboardPair(
              LogicalKeyboardKey.arrowRight, ControllerButton.DPAD_RIGHT):
          (context) => profileSliderController.nextPage(),
      ControllerKeyboardPair(
              LogicalKeyboardKey.arrowLeft, ControllerButton.DPAD_LEFT):
          (context) => profileSliderController.previousPage()
    };
  }

  @override
  State<StatefulWidget> vitualCreateState() => _ProfileSelectorState();
}

class _ProfileSelectorState extends XboxPageState<ProfileSelector> {
  late List<FocusNode> sliderItemsFocusNodes;
  late Background backgroundPreview;
  List<ProfileModel>? profilesAvailable;

  late void Function(void Function()) _updateBackground;

  @override
  void initState() {
    sliderItemsFocusNodes = List.empty(growable: true);
    backgroundPreview = Background();
    super.initState();
  }

  @override
  Widget virtualBuild(BuildContext context) {
    profilesAvailable = context.read<ProfileProvider>().profilesList;

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
                  child: backgroundPreview));
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
                  items: profilesAvailable!.map((profile) {
                    ProfileSelectorItem item = ProfileSelectorItem(
                      profileModel: profile,
                    );
                    sliderItemsFocusNodes.add(item.focusNode);
                    return item;
                  }).toList(),
                  options: CarouselOptions(
                      autoPlay: false,
                      disableCenter: true,
                      viewportFraction: 0.3,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, _) {
                        sliderItemsFocusNodes[index].requestFocus();
                        _updateBackground(() => backgroundPreview = Background(
                              profileModel: profilesAvailable![index],
                            ));
                      }),
                  carouselController: widget.profileSliderController,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
