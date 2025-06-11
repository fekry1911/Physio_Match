import 'package:flutter/material.dart';

import '../../../../core/theme/text_themes/text.dart';

void setupErrorState(BuildContext context, String error) {
  Navigator.pop(context);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(
        Icons.error,
        color: Colors.red,
        size: 32,
      ),
      content: Text(
        error,
        style: TextThemes.font12BlueRegular,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Got it',
            style: TextThemes.font12BlueRegular,
          ),
        ),
      ],
    ),
  );
}
