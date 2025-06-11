import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/const/const.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/theme/text_themes/text.dart';
import '../../../login_screen/logic/cubit/login_cubit.dart';
import '../../../login_screen/logic/cubit/login_states.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height/3,
              child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.teal),
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://i0.wp.com/digitalhealthskills.com/wp-content/uploads/2022/11/3da39-no-user-image-icon-27.png?fit=500%2C500&ssl=1",
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Text(
                        CacheHelper.getString(key: "name") ?? "01044577394",
                        style: TextThemes.font16BlackBold.copyWith(
                          color: Colors.white,
                        ),
                      ),

                    ],
                  )
              ),
            ),
            Column(
              children: [
                ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      context.pushNamed(userData);
                    },
                    child: CircleAvatar(
                      backgroundColor: Color(0xffEAF2FF),
                      //Color(0xffEAF2FF),
                      radius: 40.r,
                      child: Image.asset(
                        "assets/personalcard.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    'Profile',
                    style: TextThemes.font12BlackSemiBold.copyWith(
                      color: Color(0xff242424),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      context.read<LoginCubit>().signOut();
                    },
                    child: CircleAvatar(
                      backgroundColor: Color(0xffFFEEEF),
                      //Color(0xffEAF2FF),
                      radius: 40.r,
                      child: Image.asset(
                        "assets/logout.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    'Log Out',
                    style: TextThemes.font12BlackSemiBold.copyWith(
                      color: Color(0xff242424),
                    ),
                  ),
                ),
                BlocListener<LoginCubit,LoginStates>(listener: (context,state){
                  if(state is AuthInitial){
                    CacheHelper.removeString(key: "uid");
                    CacheHelper.removeString(key: "name");
                    CacheHelper.removeString(key: "email");
                    CacheHelper.removeString(key: "phone");
                    context.pushNamed(loginScreen);
                  }


                },
                  child: SizedBox.shrink(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
