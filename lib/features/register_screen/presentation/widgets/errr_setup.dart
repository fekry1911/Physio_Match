import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/text_themes/text.dart';

void setupState(BuildContext context, {required String error,required icon,required color,required onpressed,}) {
  Navigator.pop(context);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      icon:  Icon(
        icon,
        color: color,
        size: 32.r,
      ),
      content: Text(
        error,
        style: TextThemes.font12BlueRegular,
      ),
      actions: [
        TextButton(
          onPressed: onpressed,
          child: Text(
            'Click To verify',
            style: TextThemes.font12BlueRegular,
          ),
        ),
      ],
    ),
  );
}
