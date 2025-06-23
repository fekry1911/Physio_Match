import 'package:add_ques/core/const/const.dart';
import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/theme/text_themes/text.dart';
import '../../../../../payment/screens/payment_screen.dart';

class DoctorDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: GestureDetector(
        onTap: (){
          context.pushNamed(paymentData);
         // Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentScreen()));
        },
        child: Text("Home Screen",style: TextThemes.font14LightDarkRegular.copyWith(color: Colors.blue),)));
  }
}