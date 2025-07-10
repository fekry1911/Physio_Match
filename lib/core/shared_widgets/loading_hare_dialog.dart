import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';

 dialogLoading(context){
  return showDialog(
    context: context,
    builder:
        (context) => Center(
      child: Lottie.asset("assets/loading.json"),
    ),
  );
}