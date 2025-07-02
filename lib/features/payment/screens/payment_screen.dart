import 'package:add_ques/core/const/const.dart';
import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../doctor/logic/doctor_cubit.dart';
import '../../doctor/presentaion/doctr_home.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({Key? key, required this.url}) : super(key: key);
  final String? url;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onNavigationRequest: (NavigationRequest request) async {
                final url = request.url;
                if (url.contains('post_pay')) {
                  final uri = Uri.parse(url);
                  final success = uri.queryParameters['success'];

                  if (success == 'true') {
                 await   FirebaseFirestore.instance.collection("doctors").doc(FirebaseAuth.instance.currentUser!.uid).update(<Object, Object?>{
                      "tries": 3,
                    }).then((value){
                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text('✅ Payment successful')),
                   );
                   context.pushAndRemoveUntil(doctorHomeScreen,arguments: 1);

                 });
                  } else {
                    // ❌ الدفع فشل
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('❌ Payment failed')));
                    context.pushNamed(paymentData);
                  }
                  return NavigationDecision.prevent; // تمنع تحميل الصفحة
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.url!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paymob Payment')),
      body: WebViewWidget(controller: _controller),
    );
  }
}
