import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/const/const.dart';
import 'core/router/app_router.dart';

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
          initialRoute: splashScreen,
          title: 'First Method',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              centerTitle: false,
              scrolledUnderElevation: 0,
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            fontFamily: 'cairo',
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          /*CacheHelper.getStringToken(key: 'token')==null?SpashScreen():BlocProvider(
              create: (BuildContext context) => getIt<DoctorHomeCubit>()..getAllDocs(),
              child: HomePage(),
            ),*/
        );
      },
    );
  }
}
