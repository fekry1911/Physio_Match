import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/theme/text_themes/text.dart';

class DoctorSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Setting Screen",style: TextThemes.font14LightDarkRegular.copyWith(color: Colors.blue),));
  }
}