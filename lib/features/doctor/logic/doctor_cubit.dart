import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../di/di.dart';
import '../../home_page/logic/home_cubit.dart';
import '../../home_page/presentation/add_ques.dart';
import '../../login_screen/logic/cubit/login_cubit.dart';
import '../../user_data/logic/update_user_data_cubit.dart';
import '../../user_data/presentaion/user_ui.dart';
import '../presentaion/doctr_home.dart';
import '../presentaion/screens/content_scren/presentation/content_screen.dart';
import '../presentaion/screens/home_screen/presentation/home_screen.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(DoctorInitial());
  final List<Widget> pages = [
    DoctorDashboardScreen(),
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<HomeCubit>()),
      ],
      child: AddAllAues(),
    ),    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>sl<UpdateUserDataCubit>()..getDoctorData(FirebaseAuth.instance.currentUser!.uid),),
        BlocProvider(create: (context) => sl<LoginCubit>()),
      ],
      child: UserData(),
    ),  ];
  final List<String> titles=[
    "Home",
    "Choose specialization for quiz",
    "Profile"
  ];
  int currentIndex = 0;
  changeIndex(int index) {
    currentIndex = index;
    emit(DoctorChangeIndex());
  }

}
