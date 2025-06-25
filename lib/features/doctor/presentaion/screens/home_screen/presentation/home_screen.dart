import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/card.dart';

class DoctorDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return DoctorCard();
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(height: 1.h, color: Colors.grey);
      },
      itemCount: 10,
    );
  }
}
