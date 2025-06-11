import 'package:add_ques/features/user_data/presentaion/widgets/list_title_data.dart';
import 'package:add_ques/features/user_data/presentaion/widgets/name_email.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/colors/colors.dart';
import '../../../core/theme/text_themes/text.dart';

class UserData extends StatelessWidget {
  const UserData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainTealColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: AppBar(
          backgroundColor: AppColors.mainTealColor,
          title: Text(
            "Profile",
            style: TextThemes.font18BlackSemiBold.copyWith(color: Colors.white),
          ),
          centerTitle: true,
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: EdgeInsets.only(top: 50.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: 0,
            child: ClipOval(
              child: Image.network(
                "https://i0.wp.com/digitalhealthskills.com/wp-content/uploads/2022/11/3da39-no-user-image-icon-27.png?fit=500%2C500&ssl=1",
                fit: BoxFit.cover,
                height: 130.h,
                width: 130.h,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 160.h), // لتحت الصورة بمسافة
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NameAndEmail(),
                SizedBox(height: 20.h),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20,
                  ),
                  child: MaterialButton(
                    height: 52.h,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    elevation: 0,
                    onPressed: () {
                    },
                    color: Color(0xffF8F8F8),
                    child: Text(
                      "My Appointment",
                      style: TextThemes.font16WhiteSemiBold.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                IconAndInfo(
                  image: 'assets/personalcard.png',
                  data: 'Update My Personal Data',
                  onPreesed: () {
                  },
                  backColor: Color(0xffEAF2FF),
                ),
                Divider(height: 25.h, endIndent: 50.w, indent: 30.w),
                IconAndInfo(
                  image: 'assets/logout.png',
                  data: 'Log Out',
                  onPreesed: () {
                  },
                  backColor: Color(0xffFFEEEF),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
