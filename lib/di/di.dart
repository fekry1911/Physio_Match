// lib/core/service_locator.dart
import 'package:add_ques/features/home_page/data/rebo/get_all_ques.dart';
import 'package:add_ques/features/home_page/data/rebo/get_all_ques_impl.dart';
import 'package:add_ques/features/home_page/logic/home_cubit.dart';
import 'package:add_ques/features/quiz/data/rebo/add.dart';
import 'package:add_ques/features/quiz/logic/save_score_cubit.dart';
import 'package:add_ques/features/register_screen/data/rebo/add_user_data_rebo.dart';
import 'package:add_ques/features/register_screen/data/rebo/add_user_data_rebo_impl.dart';
import 'package:add_ques/features/user_data/data/update_user_data_impl.dart';
import 'package:add_ques/features/user_data/data/update_user_rebo.dart';
import 'package:add_ques/features/user_data/logic/update_user_data_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

import '../features/login_screen/data/rebo/login_rebo.dart';
import '../features/login_screen/data/rebo/login_rebo_imp.dart';
import '../features/login_screen/logic/cubit/login_cubit.dart';
import '../features/quiz/data/rebo/add_impl.dart';
import '../features/register_screen/cubit/register_cubit.dart';
import '../features/register_screen/data/rebo/rebo.dart';
import '../features/register_screen/data/rebo/rebo_impl.dart';
import '../features/student/data/rebo/register_repo.dart';
import '../features/student/data/rebo/register_repo_impl.dart';
import '../features/student/logic/student_cubit.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);


  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()),);
  sl.registerLazySingleton<RegisterRebo>(() => AuthRepositorySignUp(sl()));
  sl.registerLazySingleton<AddUserData>(() => AddUserDataImpl(sl()));
  sl.registerLazySingleton<GetAllQues>(() => GetAllQuesImpl(sl(),));
  sl.registerLazySingleton<AddScore>(() => AppScoreImpl(sl(),));
  sl.registerLazySingleton<UpdateUserRebo>(() => UpdateUserDataImpl(sl(),sl()));
  sl.registerLazySingleton<RegisterRepository>(() => RegisterRepoImpl(sl()));


  // Cubits
  sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl<RegisterRebo>(), sl<AddUserData>()),);
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl<AuthRepository>()));
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl<GetAllQues>()));
  sl.registerFactory<SaveScoreCubit>(() => SaveScoreCubit(sl<AddScore>(), sl<UpdateUserDataCubit>()));
  sl.registerLazySingleton<UpdateUserDataCubit>(() => UpdateUserDataCubit(sl<UpdateUserRebo>()));
  sl.registerLazySingleton<StudentRegisterCubit>(() => StudentRegisterCubit(sl<RegisterRepository>(),sl<FirebaseAuth>()));

}
