import 'package:add_ques/core/const/const.dart';
import 'package:add_ques/features/chat_bot/logic/cubit/chat_cubit.dart';
import 'package:add_ques/features/chat_bot/presentation/chat_ui.dart';
import 'package:add_ques/features/home_page/logic/home_cubit.dart';
import 'package:add_ques/features/login_screen/logic/cubit/login_cubit.dart';
import 'package:add_ques/features/login_screen/presentation/login.dart';
import 'package:add_ques/features/quiz/logic/save_score_cubit.dart';
import 'package:add_ques/features/register_screen/cubit/register_cubit.dart';
import 'package:add_ques/features/splash_screen/presentaion/splash_screen.dart';
import 'package:add_ques/features/type_register/presentation/type_register_ui.dart';
import 'package:add_ques/features/user_data/logic/update_user_data_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/di.dart';
import '../../../features/home_page/presentation/add_ques.dart';
import '../../../features/quiz/data/rebo/add.dart';
import '../../../features/quiz/presentation/qui.dart';
import '../../../features/register_screen/presentation/register_screen.dart';
import '../../../features/user_data/presentaion/user_ui.dart';
import '../../features/centers/logic/get_center_data_cubit.dart';
import '../../features/centers/presentation/screens/center_posts/ui/one_center_data.dart';
import '../../features/doctor/logic/doctor_cubit.dart';
import '../../features/doctor/presentaion/doctr_home.dart';
import '../../features/home/presentation/screens/decider_screen.dart';
import '../../features/payment/logic/payment_cubit.dart';
import '../../features/payment/screens/payment_screen.dart';
import '../../features/payment/screens/pre_payment/payment_data.dart';
import '../../features/saved_posts/logic/get_saved_posts_cubit.dart';
import '../../features/saved_posts/presentation/saved_posts_screen.dart';
import '../../features/type_register/logic/type_register_cubit.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case chatScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => ChatCubit(),
                child: ChatScreen(),
              ),
        );
      case userData:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create:
                        (context) =>
                            sl<UpdateUserDataCubit>()..getDoctorData(
                              FirebaseAuth.instance.currentUser!.uid,
                            ),
                  ),
                  BlocProvider(create: (context) => sl<LoginCubit>()),
                ],
                child: UserData(),
              ),
        );
      case quizScreen:
        final args = settings.arguments;
        if (args is List<Map<String, dynamic>>) {
          UpdateUserDataCubit updateCubit = sl<UpdateUserDataCubit>();
          return MaterialPageRoute(
            builder:
                (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: updateCubit),
                    BlocProvider(
                      create:
                          (context) =>
                              SaveScoreCubit(sl<AddScore>(), updateCubit),
                    ),
                  ],
                  child: QuizScreen(questions: args),
                ),
          );
        } else {
          return null;
        }

      case homeScreen:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [BlocProvider(create: (context) => sl<HomeCubit>())],
                child: AddAllAues(),
              ),
        );
      case loginScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => sl<LoginCubit>(),
                child: LoginScreen(),
              ),
        );
      case registerScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => sl<RegisterCubit>(),
                child: Register(),
              ),
        );
      case typeRegisterScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => sl<TypeRegisterCubit>(),
                child: TypeRegisterScreen(),
              ),
        );
      case homeDeciderScreen:
        return MaterialPageRoute(builder: (_) => HomeDeciderScreen());
      case paymentData:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => sl<PaymentCubit>(),
                child: PaymentData(),
              ),
        );
      case paymentSubmit:
        final args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => PaymentScreen(url: args.toString()),
        );
      case doctorHomeScreen:
        final args = settings.arguments;
        if (args is int) {
          return MaterialPageRoute(
            builder:
                (_) => BlocProvider(
                  create: (context) => DoctorCubit(),
                  child: DoctorHomeScreen(initialIndex: args),
                ),
          );
        } else {
          return null;
        }
      case savedPosts:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => sl<GetSavedPostsCubit>()..getPostsData(),
                child: MySavedPosts(),
              ),
        );
      case center:
        final args = settings.arguments;
        if (args is String) {
          return MaterialPageRoute(
            builder:
                (_) => BlocProvider(
                  create:
                      (context) =>
                          sl<GetCenterDataCubit>()..getCenterInfo(args),
                  child: CenterData(),
                ),
          );
        }
    }

    return null;
  }
}
