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

class ProfileSelector extends XboxPageStateful {
  String? title;
  final CarouselController _profileSliderController = CarouselController();
  void Function(BuildContext, ProfileModel) onProfileSelect;

  ProfileSelector({required this.onProfileSelect, this.title, Key? key})
      : super(key: key) {
    const Duration profileChangeAnimationTime = Duration(milliseconds: 500);
    const Curve profileChangeAnimationCurve = Curves.easeOutQuart;

    keyAction = {
      ControllerKeyboardPair(
              LogicalKeyboardKey.escape, ControllerButton.B_BUTTON):
          ((context) => Navigator.pop(context)),
      ControllerKeyboardPair(
              LogicalKeyboardKey.arrowRight, ControllerButton.DPAD_RIGHT):
          (_) => _profileSliderController.nextPage(
              curve: profileChangeAnimationCurve,
              duration: profileChangeAnimationTime),
      ControllerKeyboardPair(
              LogicalKeyboardKey.arrowLeft, ControllerButton.DPAD_LEFT):
          (_) => _profileSliderController.previousPage(
              curve: profileChangeAnimationCurve,
              duration: profileChangeAnimationTime)
    };
  }

  @override
  State<StatefulWidget> vitualCreateState() => _ProfileSelectorState();
}

class _ProfileSelectorState extends XboxPageState<ProfileSelector> {
  late List<FocusNode> _sliderItemsFocusNodes;
  Background? _backgroundPreview;
  late Key _backgroundTransitionKey;
  late List<ProfileModel> _profilesAvailable;
  late List<ProfileSelectorItem> _selectorProfileItems;
  int? _currentProfile;

  @override
  void initState() {
    super.initState();
    _sliderItemsFocusNodes = List.empty(growable: true);
    _selectorProfileItems = List.empty(growable: true);
    _backgroundTransitionKey = ValueKey(_currentProfile);
  }

  void generateSelectorItems(BuildContext context) {
    for (ProfileModel profile in _profilesAvailable) {
      ProfileSelectorItem item = ProfileSelectorItem(
        profileModel: profile,
        onSelect: () => widget.onProfileSelect(context, profile),
      );
      if (_sliderItemsFocusNodes.length != _profilesAvailable.length) {
        _sliderItemsFocusNodes.add(item.focusNode);
      }
      _selectorProfileItems.add(item);
    }
  }

  @override
  Widget virtualBuild(BuildContext context) {
    if (_selectorProfileItems.isEmpty || _sliderItemsFocusNodes.isEmpty) {
      _profilesAvailable = context.read<ProfileProvider>().profilesList!;
      generateSelectorItems(context);
    }

    _sliderItemsFocusNodes[_currentProfile ?? 0].requestFocus();
    _backgroundPreview ??= Background(profileModel: _profilesAvailable[0]);

    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _backgroundPreview),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 70.0, 8.0, 8.0),
          child: Column(
            children: [
              Flexible(
                flex: 0,
                child: Text(
                  widget.title ?? "Who's playing today?",
                  style: AppTextStyle.PROFILE_SELECTION_TITLE,
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 0,
                child: CarouselSlider(
                  items: _selectorProfileItems,
                  options: CarouselOptions(
                      autoPlay: false,
                      disableCenter: true,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.3,
                      aspectRatio: 21 / 9,
                      pageSnapping: false,
                      initialPage: _currentProfile ?? 0,
                      onPageChanged: (index, _) {
                        setState(() {
                          _currentProfile = index;
                          _backgroundTransitionKey = ValueKey(_currentProfile);
                          _backgroundPreview = Background(
                              key: _backgroundTransitionKey,
                              profileModel:
                                  _profilesAvailable[_currentProfile!]);
                        });
                      }),
                  carouselController: widget._profileSliderController,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
