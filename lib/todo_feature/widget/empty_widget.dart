import 'package:flutter/material.dart';

import '../../tools/media_query.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/box-color.png', width: getWidth(context, 0.5)),
          Text('لیست خالی است', style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }
}