import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xbox_launcher/providers/profile_providers.dart';

class ListBox extends HookConsumerWidget {
  final List<ComboBoxItem<int>> items;
  final void Function(int) onChange;
  String? placeholder;
  int? initialIndex;
  FocusNode? focusNode;
  final double? width;
  final double? height;

  ListBox(this.items,
      {Key? key,
      required this.onChange,
      this.placeholder,
      this.initialIndex,
      this.focusNode,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileTheme = ref.watch(profileThemeProvider);
    final currentValueState = useState(initialIndex ?? 0);

    return SizedBox(
      width: width,
      height: height,
      child: ComboBox<int>(
          value: currentValueState.value,
          focusNode: focusNode,
          isExpanded: true,
          popupColor: profileTheme.accentColor,
          placeholder: placeholder != null ? Text(placeholder!) : null,
          onChanged: ((value) {
            onChange(value!);
            currentValueState.value = value;
          }),
          items: items),
    );
  }
}
