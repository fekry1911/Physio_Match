import 'package:add_ques/core/const/const.dart';
import 'package:add_ques/features/chat_bot/logic/cubit/chat_cubit.dart';
import 'package:add_ques/features/chat_bot/presentation/chat_ui.dart';
import 'package:add_ques/features/home_page/logic/home_cubit.dart';
import 'package:add_ques/features/login_screen/logic/cubit/login_cubit.dart';
import 'package:add_ques/features/login_screen/presentation/login.dart';
import 'package:add_ques/features/quiz/logic/save_score_cubit.dart';
import 'package:add_ques/features/register_screen/cubit/register_cubit.dart';
import 'package:add_ques/features/splash_screen/presentaion/splash_screen.dart';
import 'package:add_ques/features/student/logic/student_cubit.dart';
import 'package:add_ques/features/user_data/logic/update_user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/di.dart';
import '../../../features/home_page/presentation/add_ques.dart';
import '../../../features/quiz/data/rebo/add.dart';
import '../../../features/quiz/presentation/qui.dart';
import '../../../features/register_screen/presentation/register_screen.dart';
import '../../../features/student/presentation/ui_student.dart';
import '../../../features/user_data/presentaion/user_ui.dart';
import '../cache_helper.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    UpdateUserDataCubit updateCubit = sl<UpdateUserDataCubit>();
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
                  BlocProvider.value(
                    value: updateCubit,
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
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: updateCubit),
                BlocProvider(
                  create: (context) => SaveScoreCubit(
                    sl<AddScore>(),
                    updateCubit,
                  ),
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
                providers: [
                  BlocProvider.value(
                   value: updateCubit,
                  ),
                  BlocProvider(create: (context) => sl<HomeCubit>()),
                ],
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
      case studentRegisterScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
            create: (context) => sl<StudentRegisterCubit>(),
            child: StepperExample(),
          ),
        );
    }
    return null;
  }
}
