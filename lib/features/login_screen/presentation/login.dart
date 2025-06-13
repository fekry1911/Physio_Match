import 'package:add_ques/core/const/const.dart';
import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:add_ques/features/login_screen/presentation/widgets/already_have_text.dart';
import 'package:add_ques/features/login_screen/presentation/widgets/email_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  Text(
                    "Welcome Back",
                    style: TextThemes.textBold24Blue,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Log in to continue your journey with PhysioMatch",
                    style: TextThemes.textGreyRegular14.copyWith(height: 2,letterSpacing: 2),
                  ),
                  SizedBox(height: 36.h),
                  BlocConsumer<LoginCubit, LoginStates>(
                    buildWhen: (context, state)=>state is ToggleSecure,
                    builder: (context, state) {
                      final cubit = context.watch<LoginCubit>();
                      return EmailAndPassword(
                        isSecure: cubit.isSecure,
                        onTap: cubit.toggleSecure,
                      );
                    },
                    listener: (BuildContext context,  state) {  },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextThemes.font12BlueRegular,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  TealButtonWithRaduis(
                    text: "Log In",
                    onTab: () {
                      if(context.read<LoginCubit>().formKey.currentState!.validate()){
                        context.read<LoginCubit>().signIn();
                      }

                    },
                  ),
                  SizedBox(height: 32.h),
                  TermAndConditions(),
                  SizedBox(height: 32.h),
                  AlreadyHaveAccount1(),
                  BlocListener<LoginCubit, LoginStates>(
                    listener: (BuildContext context,  state) {
                      if (state is AuthSuccess) {
                        setupState(
                            context,
                            error: "Loged In completed successfully",
                            icon: Icons.done,
                            color: Colors.green,
                            onpressed: () {
                              context.pushAndRemoveUntil(homeScreen);
                            });
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
                      if(state is AuthLoading){
                        showDialog(
                          context: context,
                          builder:
                              (context) => Center(
                            child: CircularProgressIndicator(
                              color: AppColors.mainTealColor,
                            ),
                          ),
                        );
                      }
                    },
                    child: SizedBox.shrink(),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
