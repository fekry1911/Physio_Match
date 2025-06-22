import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../doctor/logic/doctor_cubit.dart';
import '../../../doctor/presentaion/doctr_home.dart';
import '../../../student/presentation/student_home.dart';

class HomeDeciderScreen extends StatelessWidget {
  const HomeDeciderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final type = CacheHelper.getString(
        key: "type"); // "doctor" or "type_register"

    if (type == "Doctor") {
      return BlocProvider(
        create: (context) => DoctorCubit(),
        child: DoctorHomeScreen(),
      );
    } else if (type == "Student") {
      return StudentHomeScreen();
    } else {
      // fallback screen or login
      return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(child: Text("لم يتم التعرف على المستخدم")),
      );
    }
  }
}
