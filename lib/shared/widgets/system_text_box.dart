import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';

class SystemTextBox extends StatelessWidget {
  TextEditingController? controller;
  FocusNode? focusNode;
  String? placeholder;
  int? maxLenght;
  bool readOnly;

  SystemTextBox(
      {Key? key,
      this.controller,
      this.focusNode,
      this.placeholder,
      this.maxLenght,
      this.readOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextBox(
        key: key,
        controller: controller,
        focusNode: focusNode,
        placeholder: placeholder,
        maxLines: 1,
        maxLength: maxLenght,
        readOnly: readOnly,
        enabled: !readOnly,
        textAlign: TextAlign.left,
        highlightColor:
            Provider.of<ProfileProvider>(context, listen: false).accentColor,
        decoration: const BoxDecoration(borderRadius: BorderRadius.zero));
  }
}
