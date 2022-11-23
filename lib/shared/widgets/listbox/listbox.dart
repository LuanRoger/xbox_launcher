import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';

class ListBox extends HookWidget {
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
  Widget build(BuildContext context) {
    final currentValueState = useState(initialIndex ?? 0);

    return SizedBox(
      width: width,
      height: height,
      child: Consumer<ProfileProvider>(
        builder: (_, value, __) => ComboBox<int>(
            value: currentValueState.value,
            focusNode: focusNode,
            isExpanded: true,
            popupColor: value.accentColor,
            placeholder: placeholder != null ? Text(placeholder!) : null,
            onChanged: ((value) {
              onChange(value!);
              currentValueState.value = value;
            }),
            items: items),
      ),
    );
  }
}
