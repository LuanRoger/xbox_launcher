import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/apps_group.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateful.dart';

class GroupsReorder extends XboxPageStateful {
  const GroupsReorder({super.key});

  @override
  State<StatefulWidget> createState() => _GroupsReorderState();
}

class _GroupsReorderState
    extends XboxPageState<GroupsReorder> {
  late List<AppsGroup> _groupsCache;
  late List<FocusNode> _groupsFocus;

  bool _isSelected = false;
  int? selectedIndex;

  @override
  List<ShortcutOption>? defineMapping(BuildContext context) => null;

  @override
  void initState() {
    super.initState();
    _groupsCache = List.empty(growable: true);
    _groupsFocus = List.empty(growable: true);
    _groupsCache = context.read<ProfileProvider>().appsGroups;

    for (var _ in _groupsCache) {
      FocusNode groupFocus = FocusNode();
      groupFocus.addListener(() => reorderListBySelected(groupFocus));
      _groupsFocus.add(groupFocus);
    }
  }

  void reorderListBySelected(FocusNode focusedNode) {
    int focusedGroupIndex = _groupsFocus.indexOf(focusedNode);

    FocusNode groupFocusNode = _groupsFocus.removeAt(selectedIndex!);
    AppsGroup appsGroup = _groupsCache.removeAt(selectedIndex!);

    _groupsCache.insert(focusedGroupIndex, appsGroup);
    _groupsFocus.insert(focusedGroupIndex, groupFocusNode);
  }

  @override
  Widget virtualBuild(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return TextButton(
            title: _groupsCache[index].groupName,
            //focusNode: _groupsFocus[index],
            onPressed: () {
              if (_isSelected) {
                _isSelected = false;
                selectedIndex = null;
                return;
              }
              selectedIndex = index;
              _isSelected = true;
            },
            style: ButtonStyle(
                backgroundColor: ButtonState.all(Colors.transparent),
                shadowColor: ButtonState.all(Colors.transparent)),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemCount: _groupsCache.length);
  }
}
