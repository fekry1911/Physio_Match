import 'package:add_ques/core/const/keys/aoi_keys.dart';
import 'package:add_ques/features/payment/logic/payment_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/router/app_router.dart';
import 'features/doctor/logic/doctor_cubit.dart';
import 'features/doctor/presentaion/doctr_home.dart';
import 'features/home_page/presentation/add_ques.dart';
import 'core/const/const.dart';
import 'core/helpers/cache_helper.dart';
import 'di/di.dart';
import 'features/payment/screens/pre_payment/payment_data.dart';
import 'features/payment/service/dio_helper_payment/dio_helper_payment.dart';
import 'features/splash_screen/presentaion/splash_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: url,
    anonKey: anonKey,
  );
  await CacheHelper.init();
  DioHelperPayMent.init();

  setupServiceLocator();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(appRouter: AppRouter(),));
}

class MyApp extends StatelessWidget {

  MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.generateRoute,
            // initialRoute:splashScreen,
            home: BlocProvider(
              create: (context) => sl<DoctorCubit>(),
              child: DoctorHomeScreen(),
            ),
            title: 'First Method',
            theme: ThemeData(
              primaryColorLight: Colors.blue,
              primaryColor: Colors.blue,
              appBarTheme: AppBarTheme(
                centerTitle: false,
                scrolledUnderElevation: 0,
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
              ),
              scaffoldBackgroundColor: Colors.white,
              fontFamily: 'cairo',
              primarySwatch: Colors.blue,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            /*CacheHelper.getStringToken(key: 'token')==null?SpashScreen():BlocProvider(
              create: (BuildContext context) => getIt<DoctorHomeCubit>()..getAllDocs(),
              child: HomePage(),
            ),*/
          );
        }
    );
  }
}

