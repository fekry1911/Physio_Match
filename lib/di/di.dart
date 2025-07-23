// lib/core/service_locator.dart
import 'package:add_ques/features/centers/data/rebo/get_center_data_rebo.dart';
import 'package:add_ques/features/centers/data/rebo/rate_rebo/rate_rebo.dart';
import 'package:add_ques/features/centers/data/rebo/rate_rebo/rate_rebo_imbl.dart';
import 'package:add_ques/features/centers/logic/get_center_data_cubit.dart';
import 'package:add_ques/features/centers/logic/rate_logic/rate_cubit.dart';
import 'package:add_ques/features/doctor/presentaion/screens/home_screen/data/rebo/get_posts.dart';
import 'package:add_ques/features/doctor/presentaion/screens/home_screen/data/rebo/get_posts_impl.dart';
import 'package:add_ques/features/doctor/presentaion/screens/home_screen/logic/get_posts_cubit.dart';
import 'package:add_ques/features/home_page/data/rebo/get_all_ques.dart';
import 'package:add_ques/features/home_page/data/rebo/get_all_ques_impl.dart';
import 'package:add_ques/features/home_page/logic/home_cubit.dart';
import 'package:add_ques/features/payment/logic/payment_cubit.dart';
import 'package:add_ques/features/quiz/data/rebo/add.dart';
import 'package:add_ques/features/quiz/logic/save_score_cubit.dart';
import 'package:add_ques/features/register_screen/data/rebo/add_user_data_rebo.dart';
import 'package:add_ques/features/register_screen/data/rebo/add_user_data_rebo_impl.dart';
import 'package:add_ques/features/saved_posts/data/rebo/get_saved_posts_impl.dart';
import 'package:add_ques/features/user_data/data/update_user_data_impl.dart';
import 'package:add_ques/features/user_data/data/update_user_rebo.dart';
import 'package:add_ques/features/user_data/logic/update_user_data_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../features/centers/data/rebo/get_center_data.dart';
import '../features/login_screen/data/rebo/login_rebo.dart';
import '../features/login_screen/data/rebo/login_rebo_imp.dart';
import '../features/login_screen/logic/cubit/login_cubit.dart';
import '../features/payment/logic/paymob_service.dart';
import '../features/quiz/data/rebo/add_impl.dart';
import '../features/register_screen/cubit/register_cubit.dart';
import '../features/register_screen/data/rebo/rebo.dart';
import '../features/register_screen/data/rebo/rebo_impl.dart';
import '../features/saved_posts/data/rebo/get_saved_posts.dart';
import '../features/saved_posts/logic/get_saved_posts_cubit.dart';
import '../features/type_register/data/rebo/register_repo.dart';
import '../features/type_register/data/rebo/register_repo_impl.dart';
import '../features/type_register/logic/type_register_cubit.dart';

final sl = GetIt.instance;

void setupServiceLocator() {

  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);


  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(),sl()),);
  sl.registerLazySingleton<RegisterRebo>(() => AuthRepositorySignUp(sl()));
  sl.registerLazySingleton<AddUserData>(() => AddUserDataImpl(sl()));
  sl.registerLazySingleton<GetAllQues>(() => GetAllQuesImpl(sl(),));
  sl.registerLazySingleton<AddScore>(() => AppScoreImpl(sl(),));
  sl.registerLazySingleton<UpdateUserRebo>(() => UpdateUserDataImpl(sl()));
  sl.registerLazySingleton<RegisterRepository>(() => RegisterRepoImpl(sl()));
  sl.registerLazySingleton<GetPosts>(() => GetPostsImpl(sl()));
  sl.registerLazySingleton<GetSavedPosts>(() => GetSavedPostsImpl(sl()));
  sl.registerLazySingleton<GetCenterData>(() => GetCenterDataImpl(sl()));
  sl.registerLazySingleton<RateRebo>(() => RateReboImpl(sl()));

  // payment
  sl.registerLazySingleton<PaymobService>(() => PaymobService());

  // Cubits
  sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl<RegisterRebo>(), sl<AddUserData>()),);
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl<AuthRepository>()));
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl<GetAllQues>()));
  sl.registerFactory<SaveScoreCubit>(() => SaveScoreCubit(sl<AddScore>(), sl<UpdateUserDataCubit>()));
  sl.registerFactory<UpdateUserDataCubit>(() => UpdateUserDataCubit(sl<UpdateUserRebo>()));
  sl.registerFactory<TypeRegisterCubit>(() => TypeRegisterCubit(sl<RegisterRepository>(),sl<FirebaseAuth>()));
  sl.registerFactory<PaymentCubit>(() => PaymentCubit(sl<PaymobService>(),));
  sl.registerFactory<GetPostsCubit>(() => GetPostsCubit(sl<GetPosts>(),));
  sl.registerFactory<GetSavedPostsCubit>(() => GetSavedPostsCubit(sl<GetSavedPosts>(),));
  sl.registerFactory<GetCenterDataCubit>(() => GetCenterDataCubit(sl<GetCenterData>(),));
  sl.registerFactory<RateCubit>(() => RateCubit(sl<RateRebo>(),));

}
