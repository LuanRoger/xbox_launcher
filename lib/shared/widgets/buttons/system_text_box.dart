import 'package:fluent_ui/fluent_ui.dart';

class SystemTextBox extends TextBox {
  SystemTextBox(
      {Key? key,
      TextEditingController? controller,
      FocusNode? focusNode,
      String? placeholder,
      int? maxLenght,
      Color? color,
      void Function(String value)? onChanged,
      bool readOnly = false})
      : super(
            key: key,
            controller: controller,
            focusNode: focusNode,
            placeholder: placeholder,
            maxLines: 1,
            maxLength: maxLenght,
            readOnly: readOnly,
            enabled: !readOnly,
            textAlign: TextAlign.left,
            highlightColor: color,
            onChanged: onChanged,
            decoration: const BoxDecoration(borderRadius: BorderRadius.zero));
}
