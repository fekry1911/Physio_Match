import 'package:add_ques/core/const/keys/aoi_keys.dart';
import 'package:add_ques/my_app.dart';
import 'package:clarity_flutter/clarity_flutter.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/helpers/cache_helper.dart';
import 'core/router/app_router.dart';
import 'di/di.dart';
import 'features/payment/service/dio_helper_payment/dio_helper_payment.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: url, anonKey: anonKey);
  await CacheHelper.init();
  DioHelperPayMent.init();
  final config = ClarityConfig(
      projectId: "sbhso1e66x"
  );
  setupServiceLocator();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );
  runApp(ClarityWidget(
    app:MyApp(appRouter: AppRouter()),
    clarityConfig: config,
  ));
}

