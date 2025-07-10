import 'package:add_ques/core/const/const.dart';
import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:add_ques/features/register_screen/presentation/widgets/already_have_text.dart';
import 'package:add_ques/features/register_screen/presentation/widgets/email_password.dart';
import 'package:add_ques/features/register_screen/presentation/widgets/errr_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/shared_widgets/loading_hare_dialog.dart';
import '../../../core/shared_widgets/shared_button.dart';
import '../../../core/theme/text_themes/text.dart';
import '../../login_screen/presentation/widgets/term_text.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

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
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 25.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hi Doc", style: TextThemes.textBold24Blue)
                    .animate()
                    .slideX(duration: durationAnimate.ms, begin: -1, end: 0),
                SizedBox(height: 8.h),
                Text(
                  "Join PhysioMatch – where physiotherapists and medical centers connect",
                  style: TextThemes.textGreyRegular14,
                ).animate().slideY(
                  duration: durationAnimate.ms,
                  begin: -1,
                  end: 0,
                ),
                SizedBox(height: 36.h),
                BlocConsumer<RegisterCubit, RegisterStates>(
                  builder: (context, state) {
                    final cubit = context.watch<RegisterCubit>();
                    return EmailAndPassword1(
                      isSecure: cubit.isSecure,
                      onTap: cubit.changeSecure,
                    );
                  },
                  listener: (BuildContext context, state) {},
                ),

                SizedBox(height: 32.h),
                TealButtonWithRaduis(
                  text: "Register",
                  onTab: () {
                    if (context
                        .read<RegisterCubit>()
                        .formKey
                        .currentState!
                        .validate()) {
                      context.read<RegisterCubit>().registerUser();
                    }
                  },
                ).animate().fadeIn(duration: 1000.ms),
                SizedBox(height: 32.h),
                TermAndConditions().animate().slideX(
                  duration: durationAnimate.ms,
                  begin: 1,
                  end: 0,
                ),
                SizedBox(height: 32.h),
                AlreadyHaveAccount(),
                BlocListener<RegisterCubit, RegisterStates>(
                  listener: (BuildContext context, state) {
                    if (state is RegisterSuccess) {
                      context.pushNamed(typeRegisterScreen);
                    }
                    if (state is RegisterFailure) {
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
                    if (state is RegisterLoading) {
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
    );
  }
}
