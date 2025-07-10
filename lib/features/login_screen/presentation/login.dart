import 'dart:convert';

import 'package:add_ques/core/const/const.dart';
import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:add_ques/features/login_screen/presentation/widgets/already_have_text.dart';
import 'package:add_ques/features/login_screen/presentation/widgets/email_password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../core/shared_widgets/loading_hare_dialog.dart';
import '../../../core/shared_widgets/shared_button.dart';
import '../../../core/theme/colors/colors.dart';
import '../../../core/theme/text_themes/text.dart';
import '../../register_screen/presentation/widgets/errr_setup.dart';
import '../../register_screen/presentation/widgets/term_text.dart';
import '../logic/cubit/login_cubit.dart';
import '../logic/cubit/login_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      maintainBottomViewPadding: true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome Back", style: TextThemes.textBold24Blue).animate().slideY(duration: durationAnimate.ms, begin: -1.0, end: 0.0),
                  SizedBox(height: 8.h),
                  Text(
                    "Log in to continue your journey with PhysioMatch",
                    style: TextThemes.textGreyRegular14.copyWith(
                      height: 2,
                      letterSpacing: 2,
                    ),
                  ).animate().slideX(duration: durationAnimate.ms, begin: -1.0, end: 0.0),
                  SizedBox(height: 36.h),
                  BlocConsumer<LoginCubit, LoginStates>(
                    buildWhen: (context, state) => state is ToggleSecure,
                    builder: (context, state) {
                      final cubit = context.watch<LoginCubit>();
                      return EmailAndPassword(
                        isSecure: cubit.isSecure,
                        onTap: cubit.toggleSecure,
                      );
                    },
                    listener: (BuildContext context, state) {},
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          final firestore = FirebaseFirestore.instance;

                          try {
                            // Load JSON file from assets
                            String data = await rootBundle.loadString(
                              'assets/ques/Women’s Health.json',
                            );
                            Map<String, dynamic> parsed = jsonDecode(data);

                            String specialty = parsed['specialty'];
                            List<dynamic> questions = parsed['questions'];

                            for (int i = 0; i < questions.length; i++) {
                              var question = questions[i];

                              await firestore
                                  .collection('questions')
                                  .doc(
                                    specialty,
                                  ) // Use specialty name as document
                                  .collection(
                                    'items',
                                  ) // Store actual questions as subcollection
                                  .add({
                                    'question': question['question'],
                                    'options': List<String>.from(
                                      question['options'],
                                    ),
                                    'correctAnswer': question['correctAnswer'],
                                  });
                            }

                            print(
                              '✅ Questions for "$specialty" uploaded successfully!',
                            );
                          } catch (e) {
                            print('❌ Error uploading: $e');
                          }
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextThemes.font12BlueRegular,
                        ),
                      ).animate().slideX(),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  TealButtonWithRaduis(
                    text: "Log In",
                    onTab: () {
                      if (context
                          .read<LoginCubit>()
                          .formKey
                          .currentState!
                          .validate()) {
                        context.read<LoginCubit>().signIn();
                      }
                    },
                  ).animate().fadeIn(duration: 1000.ms),
                  SizedBox(height: 32.h),
                  TermAndConditions().animate().slideY(duration: durationAnimate.ms),
                  SizedBox(height: 32.h),
                  AlreadyHaveAccount1().animate().slideY(duration: durationAnimate.ms,begin: -1,end: 0),
                  BlocListener<LoginCubit, LoginStates>(
                    listener: (BuildContext context, state) {
                      if (state is AuthSuccess) {
                        context.pushAndRemoveUntil(homeDeciderScreen);
                      }
                      if (state is AuthFailure) {
                        setupState(
                          context,
                          error: state.error,
                          icon: Icons.error,
                          color: Colors.red,
                          onpressed: () {
                            Navigator.pop(context);
                          },
                        );
                      }
                      if (state is AuthLoading) {
                        dialogLoading(context);
                      }
                    },
                    child: SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
