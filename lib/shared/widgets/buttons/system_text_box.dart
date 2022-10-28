import 'package:fluent_ui/fluent_ui.dart';

class SystemTextBox extends TextBox {
  const SystemTextBox(
      {super.key,
      super.controller,
      super.focusNode,
      super.placeholder,
      super.maxLength,
      super.highlightColor,
      super.onChanged,
      bool readOnly = false})
      : super(
          maxLines: 1,
          readOnly: readOnly,
          enabled: !readOnly,
          textAlign: TextAlign.left,
          decoration: const BoxDecoration(borderRadius: BorderRadius.zero),
        );
}
