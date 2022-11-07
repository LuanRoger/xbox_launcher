import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';

class ListBox extends StatefulWidget {
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
  State<ListBox> createState() => _ListBoxState();
}

class _ListBoxState extends State<ListBox> {
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
      child: ComboBox<int>(
          value: currentValue,
          focusNode: widget.focusNode,
          isExpanded: true,
          popupColor: accentColor,
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
