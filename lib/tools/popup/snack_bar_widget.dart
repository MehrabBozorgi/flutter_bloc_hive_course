import 'package:flutter/material.dart';

import '../style/shapes.dart';

getSnackBarWidget(BuildContext context, String text, Color color) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      shape: getShapeWidget(10),
      behavior: SnackBarBehavior.floating,
      content: Text(text),
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(milliseconds: 2000),
    ),
  );
}
