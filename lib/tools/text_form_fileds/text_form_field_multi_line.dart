import 'package:flutter/material.dart';

class TextFormFieldMultiLine extends StatelessWidget {
  final int minLine;
  final int maxLine;
  final Widget? icon;
  final String labelText;
  final TextInputAction textInputAction;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextEditingController controller;

  const TextFormFieldMultiLine({
    super.key,
    required this.minLine,
    required this.maxLine,
    required this.labelText,
    required this.textInputAction,
    required this.floatingLabelBehavior,
    required this.controller,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      style: theme.textTheme.bodyMedium,

      // textInputAction: textInputAction,
      keyboardType: TextInputType.multiline,
      minLines: minLine,
      maxLines: maxLine,
      controller: controller,
      decoration: InputDecoration(
        counter: const SizedBox.shrink(),
        prefixIcon: icon,
        labelText: labelText,
        floatingLabelBehavior: floatingLabelBehavior,
      ),
      validator: (String? value) {
        if (value!.trim().isEmpty) {
          return 'این فیلد نمی تواند خالی باشد';
        }

        return null;
      },
      onTap: () {
        if (controller.text.isNotEmpty) {
          if (controller.text[controller.text.length - 1] != ' ') {
            controller.text = (controller.text + ' ');
          }
          if (controller.selection ==
              TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length - 1))) {}
        }
      },
    );
  }
}
