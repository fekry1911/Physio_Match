import 'package:add_ques/core/theme/colors/colors.dart';
import 'package:add_ques/core/theme/text_themes/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/doctor_cubit.dart';

class DoctorHomeScreen extends StatefulWidget {
  @override
  _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<DoctorCubit>(context);
    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          body: cubit.pages[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.blackColor,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.feed),
                label: 'My Document',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Setting',
              ),
            ],
          ),
        );
      },
    );
  }
}
