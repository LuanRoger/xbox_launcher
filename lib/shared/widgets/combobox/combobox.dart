import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';

class ComboBox extends StatefulWidget {
  final List<ComboboxItem<int>> items;
  final void Function(int) onChange;
  String? placeholder;
  int? initialIndex;
  FocusNode? focusNode;
  final double? width;
  final double? height;

  ComboBox(this.items,
      {Key? key,
      required this.onChange,
      this.placeholder,
      this.initialIndex,
      this.focusNode,
      this.width,
      this.height})
      : super(key: key);

  @override
  State<ComboBox> createState() => _ComboBoxState();
}

class _ComboBoxState extends State<ComboBox> {
  late int currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    Color accentColor = context.read<ProfileProvider>().accentColor;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Combobox<int>(
          value: currentValue,
          isExpanded: true,
          focusNode: widget.focusNode,
          focusColor: accentColor,
          comboboxColor: accentColor,
          placeholder:
              widget.placeholder != null ? Text(widget.placeholder!) : null,
          onChanged: ((value) {
            widget.onChange(value!);
            setState(() {
              currentValue = value;
            });
          }),
          items: widget.items),
    );
  }
}
