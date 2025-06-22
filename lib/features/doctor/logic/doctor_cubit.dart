import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../presentaion/doctr_home.dart';
import '../presentaion/screens/content_scren/presentation/content_screen.dart';
import '../presentaion/screens/home_screen/presentation/home_screen.dart';
import '../presentaion/screens/quiz_screen/presentation/quiz_screen.dart';
import '../presentaion/screens/setting_screen/presentation/setting_screen.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(DoctorInitial());
  final List<Widget> pages = [
    DoctorDashboardScreen(),
    DoctorFilesScreen(),
    MedicalFeedScreen(),
    DoctorSettingsScreen(),
  ];
  final List<String> titles=[
    "Home",
    "quiz",
    "Revision",
    "setting"
  ];
  int currentIndex = 0;
  changeIndex(int index) {
    currentIndex = index;
    emit(DoctorChangeIndex());
  }

}
