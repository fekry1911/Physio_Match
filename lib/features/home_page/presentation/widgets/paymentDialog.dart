import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:flutter/material.dart';

import '../../../../core/const/const.dart';

void showPaymentDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(Icons.payment, color: Colors.teal),
            SizedBox(width: 10),
            Text("Complete Your Payment"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "You're almost there! Tap the button below to securely pay and enjoy premium access.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                context.pushNamed(paymentData);
              },
              icon: Icon(Icons.lock),
              label: Text("Pay Now"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      );
    },
  );
}
