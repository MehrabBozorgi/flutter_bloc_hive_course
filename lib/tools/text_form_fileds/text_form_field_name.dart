import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldNameWidget extends StatelessWidget {
  final String labelText;
  final Widget? icon;
  final int maxLength;
  final TextInputAction textInputAction;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextEditingController controller;

  const TextFormFieldNameWidget({
    super.key,
    required this.maxLength,
    required this.labelText,
    required this.icon,
    required this.textInputAction,
    required this.floatingLabelBehavior,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      maxLength: maxLength,
      style: theme.textTheme.bodyMedium,
      textDirection: TextDirection.rtl,
      inputFormatters: [
        FilteringTextInputFormatter.deny(
          RegExp(
            r'[1234567890!@#<>?":_`;،,.$%^&*«»ًٌٍَُِّ؛؟)(_+|{}":؟><ء[\]\\|=+)(/*&^%-0]',
          ),
        ),
      ],
      textInputAction: textInputAction,
      keyboardType: TextInputType.name,
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: icon,
          labelText: labelText,
          floatingLabelBehavior: floatingLabelBehavior,
          counter: const SizedBox.shrink()),
      onTap: () {
        if (controller.text.isNotEmpty) {
          if (controller.text[controller.text.length - 1] != ' ') {
            controller.text = (controller.text + ' ');
          }
          if (controller.selection ==
              TextSelection.fromPosition(TextPosition(offset: controller.text.length - 1))) {}
        }
      },
      validator: (String? value) {
        if (value!.trim().isEmpty) {
          return 'این فیلد نمی تواند خالی باشد';
        }

        if (value.trim().length <= 2) {
          return 'این فیلد نمی تواند کمتر از 3 کارکتر باشد';
        }
        return null;
      },
    );
  }
}
