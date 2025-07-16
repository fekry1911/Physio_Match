import 'package:add_ques/features/doctor/presentaion/screens/home_screen/logic/get_posts_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/di.dart';
import '../../centers/logic/get_center_data_cubit.dart';
import '../../centers/presentation/screens/all_centers/center_data.dart';
import '../../home_page/logic/home_cubit.dart';
import '../../home_page/presentation/add_ques.dart';
import '../../login_screen/logic/cubit/login_cubit.dart';
import '../../user_data/logic/update_user_data_cubit.dart';
import '../../user_data/presentaion/user_ui.dart';
import '../presentaion/screens/home_screen/presentation/home_screen.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(DoctorInitial());
  final List<Widget> pages = [
    BlocProvider(
      create: (context) => sl<GetPostsCubit>()..getPostsData(),
      child: DoctorDashboardScreen(),
    ),
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => sl<HomeCubit>())],
      child: AddAllAues(),
    ),
    BlocProvider(
      create: (context) => sl<GetCenterDataCubit>()..getAdminData(),
      child: AllCentersData(),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  sl<UpdateUserDataCubit>()
                    ..getDoctorData(FirebaseAuth.instance.currentUser!.uid),
        ),
        BlocProvider(create: (context) => sl<LoginCubit>()),
      ],
      child: UserData(),
    ),
  ];
  final List<String> titles = [
    "Home",
    "Choose specialization for quiz",
    "Centers",
    "Profile",
  ];
  int currentIndex = 0;

  changeIndex(int index) {
    currentIndex = index;
    emit(DoctorChangeIndex());
  }
}
