
import 'package:add_ques/core/const/const.dart';
import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:add_ques/features/register_screen/presentation/widgets/already_have_text.dart';
import 'package:add_ques/features/register_screen/presentation/widgets/email_password.dart';
import 'package:add_ques/features/register_screen/presentation/widgets/errr_setup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/shared_widgets/shared_button.dart';
import '../../../core/theme/colors/colors.dart';
import '../../../core/theme/text_themes/text.dart';
import '../../login_screen/logic/cubit/login_cubit.dart';
import '../../login_screen/presentation/login.dart';
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
                Text(
                  "Hi Doc",
                  style: TextThemes.textBold24Blue,
                ),
                SizedBox(height: 8.h),
                Text(
                  "Join PhysioMatch – where physiotherapists and medical centers connect",
                  style: TextThemes.textGreyRegular14,
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
                  listener: (BuildContext context, state) {  },
                ),
      
                SizedBox(height: 32.h),
                TealButtonWithRaduis(
                  text: "Register",
                  onTab: () {
                    if(context.read<RegisterCubit>().formKey.currentState!.validate()){
                      context.read<RegisterCubit>().registerUser();
                    }

                  },
                ),
                SizedBox(height: 32.h),
                TermAndConditions(),
                SizedBox(height: 32.h),
                AlreadyHaveAccount(),
                BlocListener<RegisterCubit, RegisterStates>(
                  listener: (BuildContext context,  state) {
                    if (state is RegisterSuccess) {
                      setupState(
                          context,
                          error: "Registration completed successfully",
                          icon: Icons.done,
                          color: Colors.green,
                          onpressed: () {
                            context.pushNamed(loginScreen);
                          });
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
                    if(state is RegisterLoading){
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
    );
  }
}
