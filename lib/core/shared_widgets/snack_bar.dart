import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snackbar_plus/flutter_snackbar_plus.dart';

void AwesomeSnackBar(
    {required context,required tittle,required message}){
  FlutterSnackBar.showTemplated(
    context,
    title: tittle,
    message:message,
    leading: Icon(
      Icons.error,
      size: 32,
      color: Colors.red[900],
    ),
    style: FlutterSnackBarStyle(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      radius: BorderRadius.circular(6),
      backgroundColor: Colors.red[400],
      shadow: BoxShadow(
        color: Colors.black.withOpacity(0.55),
        blurRadius: 32,
        offset: const Offset(0, 12),
        blurStyle: BlurStyle.normal,
        spreadRadius: -10,
      ),
      leadingSpace: 22,
      trailingSpace: 12,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      titleStyle: const TextStyle(fontSize: 20, color: Colors.white),
      messageStyle:
      TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.7)),
      titleAlignment: TextAlign.start,
      messageAlignment: TextAlign.start,
    ),
    configuration: const FlutterSnackBarConfiguration(
      location: FlutterSnackBarLocation.bottom,
      distance: 35,
      animationCurve: Curves.ease,
      animationDuration: Duration(milliseconds: 500),
      showDuration: Duration(seconds: 6),
      dismissible: true,
      dismissDirection: DismissDirection.down,
    ),
  );

}