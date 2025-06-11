import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/text_themes/text.dart';


class NameAndEmail extends StatelessWidget {
  const NameAndEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(CacheHelper.getString(key: "name"),style: TextThemes.font22BlackMedium.copyWith(color: Colors.black),),
        SizedBox(height: 10.h,),
        Text(CacheHelper.getString(key: "email"),style: TextThemes.font14LightDarkRegular,),

      ],
    );
  }
}
