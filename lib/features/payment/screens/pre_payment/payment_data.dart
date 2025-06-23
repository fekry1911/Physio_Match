import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:add_ques/core/shared_widgets/shared_text_form_field.dart';
import 'package:add_ques/core/theme/colors/colors.dart';
import 'package:add_ques/core/theme/text_themes/text.dart';
import 'package:add_ques/features/payment/logic/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/const/const.dart';
import '../../../register_screen/presentation/widgets/errr_setup.dart';

class PaymentData extends StatelessWidget {
  const PaymentData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Form(
        key: context.read<PaymentCubit>().formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Image.asset("assets/payment.png", height: 200.h, width: 150.w),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Expanded(
                    child: SharedTextFormField(
                      controller: context.read<PaymentCubit>().firstName,
                      hintText: "first name",
                      validator: (validator) {
                        if (validator!.isEmpty) {
                          return "Please Enter First Name";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10.h),
                  Expanded(
                    child: SharedTextFormField(
                      controller: context.read<PaymentCubit>().lastName,
                      hintText: "last name",
                      validator: (validator) {
                        if (validator!.isEmpty) {
                          return "Please Enter Last Name";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              SharedTextFormField(
                controller: context.read<PaymentCubit>().email,
                hintText: "Email",
                validator: (validator) {
                  if (validator!.isEmpty) {
                    return "Please Enter Email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.h),
              SharedTextFormField(
                controller: context.read<PaymentCubit>().phone,
                hintText: "Phone",
                validator: (validator) {
                  if (validator!.isEmpty) {
                    return "Please Enter Phone";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.h),
              SharedTextFormField(
                controller: context.read<PaymentCubit>().street,
                hintText: "Address",
                validator: (validator) {
                  if (validator!.isEmpty) {
                    return "Please Enter Address";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.h),
              SharedTextFormField(
                controller: context.read<PaymentCubit>().city,
                hintText: "City",
                validator: (validator) {
                  if (validator!.isEmpty) {
                    return "Please Enter City";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.h),
              MaterialButton(
                height: 60.h,
                shape: StadiumBorder(),
                onPressed: () {
                  if (context
                      .read<PaymentCubit>()
                      .formKey
                      .currentState!
                      .validate()) {
                    context.read<PaymentCubit>().initiatePayment();
                  }
                },
                color: AppColors.mainTealColor,
                child: Text(
                  "Payment",
                  style: TextThemes.font18BlackSemiBold.copyWith(
                    color: Colors.white,
                    fontSize: 30.sp,
                  ),
                ),
              ),
              BlocListener<PaymentCubit, PaymentState>(
                listener: (BuildContext context, state) {
                  if (state is PaymentSucc) {
                    Navigator.pop(context);
                    context.pushNamed(paymentSubmit, arguments: state.url);
                  }
                  if (state is PaymentFail) {
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
                  if (state is PaymentLoading) {
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
