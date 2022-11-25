import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/models/profile_model.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/pages/profile_selector/widgets/profile_selector_item.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/hooks/element_focus_node_hook.dart';
import 'package:xbox_launcher/shared/widgets/background.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_node.dart';
import 'package:xbox_launcher/shared/widgets/xbox_page.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class ProfileSelector extends XboxPage {
  final String? title;
  final void Function(BuildContext, ProfileModel) onProfileSelect;

  final CarouselController profileSliderController = CarouselController();
  Background? _backgroundPreview;
  late List<ProfileModel> _profilesAvailable;

  ProfileSelector({required this.onProfileSelect, this.title, Key? key})
      : super(key: key);

  @override
  List<ShortcutOption> defineMapping(BuildContext context) {
    const Duration profileChangeAnimationTime = Duration(milliseconds: 500);
    const Curve profileChangeAnimationCurve = Curves.easeOutQuart;

    return [
      ShortcutOption("Back",
          controllerKeyboardPair: ControllerKeyboardPair(
              const SingleActivator(LogicalKeyboardKey.escape),
              ControllerButton.B_BUTTON),
          action: (context) => Navigator.pop(context)),
      ShortcutOption("",
          controllerKeyboardPair: ControllerKeyboardPair(
              const SingleActivator(LogicalKeyboardKey.arrowRight),
              ControllerButton.DPAD_RIGHT),
          action: (_) => profileSliderController.nextPage(
              curve: profileChangeAnimationCurve,
              duration: profileChangeAnimationTime),
          show: false),
      ShortcutOption("",
          controllerKeyboardPair: ControllerKeyboardPair(
              const SingleActivator(LogicalKeyboardKey.arrowLeft),
              ControllerButton.DPAD_LEFT),
          action: (_) => profileSliderController.previousPage(
              curve: profileChangeAnimationCurve,
              duration: profileChangeAnimationTime),
          show: false)
    ];
  }

  @override
  Widget virtualBuild(BuildContext context) {
    final sliderItemsFocusNodesState =
        useState<List<ElementFocusNode>>(List.empty(growable: true));
    final selectorProfileItemsState =
        useState<List<ProfileSelectorItem>>(List.empty(growable: true));
    final currentProfileState = useState(0);
    final backgroundTransitionKeyState =
        useState<ValueKey>(ValueKey(currentProfileState.value));

    if (selectorProfileItemsState.value.isEmpty ||
        sliderItemsFocusNodesState.value.isEmpty) {
      _profilesAvailable = context.read<ProfileProvider>().profilesList!;
      for (ProfileModel profile in _profilesAvailable) {
        ProfileSelectorItem item = ProfileSelectorItem(
          profileModel: profile,
          onSelect: () => onProfileSelect(context, profile),
          focusNode: useElementFocusNode(elementsFocusScope),
        );
        if (sliderItemsFocusNodesState.value.length !=
            _profilesAvailable.length) {
          sliderItemsFocusNodesState.value.add(item.focusNode!);
        }
        selectorProfileItemsState.value.add(item);
      }
    }

    sliderItemsFocusNodesState.value[currentProfileState.value].requestFocus();
    _backgroundPreview ??= Background(profileModel: _profilesAvailable[0]);

    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _backgroundPreview),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 55.0, 8.0, 8.0),
          child: Column(
            children: [
              Flexible(
                flex: 0,
                child: Text(
                  title ?? "Who's playing today?",
                  style: AppTextStyle.PROFILE_SELECTION_TITLE,
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 0,
                child: CarouselSlider(
                  items: selectorProfileItemsState.value,
                  options: CarouselOptions(
                      autoPlay: false,
                      disableCenter: true,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.3,
                      aspectRatio: 21 / 9,
                      pageSnapping: false,
                      initialPage: currentProfileState.value,
                      onPageChanged: (index, _) {
                        currentProfileState.value = index;
                        _backgroundPreview = Background(
                            key: backgroundTransitionKeyState.value,
                            profileModel:
                                _profilesAvailable[currentProfileState.value]);
                      }),
                  carouselController: profileSliderController,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
