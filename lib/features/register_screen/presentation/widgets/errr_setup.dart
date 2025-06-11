import 'package:flutter/material.dart';

import '../../../../core/theme/text_themes/text.dart';

void    setupState(BuildContext context, {required String error,required icon,required color,required onpressed,}) {
  Navigator.pop(context);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      icon:  Icon(
        icon,
        color: color,
        size: 32,
      ),
      content: Text(
        error,
        style: TextThemes.font12BlueRegular,
      ),
      actions: [
        TextButton(
          onPressed: onpressed,
          child: Text(
            'Got it',
            style: TextThemes.font12BlueRegular,
          ),
        ),
      ],
    ),
  );
}
