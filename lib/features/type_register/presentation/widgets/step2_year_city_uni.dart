import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared_widgets/shared_text_form_field.dart';
import '../../../../core/theme/colors/colors.dart';
import '../../../../core/theme/text_themes/text.dart';
import '../../logic/type_register_cubit.dart';

class SetUniAndYearAndCity extends StatelessWidget {
  const SetUniAndYearAndCity({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<TypeRegisterCubit>(context);
    return Padding(
      padding: EdgeInsets.all(20.0.sign),
      child: Form(
        key: cubit.formKeys[1],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter Your university Name",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainTealColor,
              ),
            ),
            SizedBox(height: 15.h),
            GestureDetector(
              onTap: () {
                DropDownState<String>(
                  dropDown: DropDown<String>(
                    data: <SelectedListItem<String>>[
                  SelectedListItem(data: 'Cairo University – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'Kafr El-Sheikh University – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'Beni Suef University – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'South Valley University – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'Suez University – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'Zagazig University – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'Menoufia University – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'Sinai University – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'October 6 University – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'MUST – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'Pharos University – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'BUC – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'Delta University – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'MTI – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'Horus University – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'Nahda University – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'Egyptian Russian University – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'Sphinx University – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'Al Salam University – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'Merit University – Faculty of Physical Therapy'),
                    SelectedListItem(data: 'NGU – Faculty of Physical Therapy'),

                    ],
                    onSelected: (selectedItems) {
                      if (selectedItems.isNotEmpty) {
                        cubit.universityController.text = selectedItems.first.data;
                      }
                    },
                  ),
                ).showModal(context);
              },
              child: SharedTextFormField(
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                  size: 40.r,
                ),
                enabled: false,
                hintText: "Enter Your university Name",
                validator: (validator) {
                  if (validator!.isEmpty) {
                    return "Enter Your university Name";
                  }
                  return null;
                },
                controller: cubit.universityController,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Enter Your city",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainTealColor,
              ),
            ),
            SizedBox(height: 15.h),
            GestureDetector(
              onTap: () {
                DropDownState<String>(
                  dropDown: DropDown<String>(
                    data: <SelectedListItem<String>>[
                      SelectedListItem(data: 'القاهرة'),
                      SelectedListItem(data: 'الجيزة'),
                      SelectedListItem(data: 'الأسكندرية'),
                      SelectedListItem(data: 'الدقهلية'),
                      SelectedListItem(data: 'البحر الأحمر'),
                      SelectedListItem(data: 'البحيرة'),
                      SelectedListItem(data: 'الفيوم'),
                      SelectedListItem(data: 'الغربية'),
                      SelectedListItem(data: 'الإسماعيلية'),
                      SelectedListItem(data: 'المنوفية'),
                      SelectedListItem(data: 'المنيا'),
                      SelectedListItem(data: 'القليوبية'),
                      SelectedListItem(data: 'الوادي الجديد'),
                      SelectedListItem(data: 'السويس'),
                      SelectedListItem(data: 'أسوان'),
                      SelectedListItem(data: 'أسيوط'),
                      SelectedListItem(data: 'بني سويف'),
                      SelectedListItem(data: 'بورسعيد'),
                      SelectedListItem(data: 'دمياط'),
                      SelectedListItem(data: 'الشرقية'),
                      SelectedListItem(data: 'جنوب سيناء'),
                      SelectedListItem(data: 'كفر الشيخ'),
                      SelectedListItem(data: 'مطروح'),
                      SelectedListItem(data: 'الأقصر'),
                      SelectedListItem(data: 'قنا'),
                      SelectedListItem(data: 'شمال سيناء'),
                      SelectedListItem(data: 'سوهاج'),
                    ],
                    onSelected: (selectedItems) {
                      if (selectedItems.isNotEmpty) {
                        cubit.cityController.text = selectedItems.first.data;
                      }
                    },
                  ),
                ).showModal(context);
              },
              child: SharedTextFormField(
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                  size: 40.r,
                ),
                enabled: false,
                hintText: "Enter Your city",
                validator: (validator) {
                  if (validator!.isEmpty) {
                    return "please Enter city";
                  }
                  return null;
                },
                controller: cubit.cityController,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Enter Your Specialization",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainTealColor,
              ),
            ),
            SizedBox(height: 15.h),
            GestureDetector(
              onTap: () {
                DropDownState<String>(
                  dropDown: DropDown<String>(
                    data: <SelectedListItem<String>>[
                      SelectedListItem(data: 'Cardiopulmonary'),
                      SelectedListItem(data: 'Geriatric'),
                      SelectedListItem(data: 'ICU'),
                      SelectedListItem(data: 'Neurological'),
                      SelectedListItem(data: 'Occupational'),
                      SelectedListItem(data: 'Orthopedic'),
                      SelectedListItem(data: 'Pediatric'),
                      SelectedListItem(data: 'Women’s Health'),
                    ],
                    onSelected: (selectedItems) {
                      if (selectedItems.isNotEmpty) {
                        cubit.specializationController.text =
                            selectedItems.first.data;
                      }
                    },
                  ),
                ).showModal(context);
              },
              child: SharedTextFormField(
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                  size: 40.r,
                ),
                enabled: false,
                hintText: "Enter Your Specialization",
                validator: (validator) {
                  if (validator!.isEmpty) {
                    return "please Enter city";
                  }
                  return null;
                },
                controller: cubit.specializationController,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Enter Your Birth"
              "day",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainTealColor,
              ),
            ),
            SizedBox(height: 15.h),
            GestureDetector(
              onTap: () {
                cubit.selectDate(context);
              },
              child: SharedTextFormField(
                suffixIcon: Icon(
                  Icons.calendar_month,
                  color: Colors.grey,
                  size: 30.r,
                ),
                enabled: false,
                hintText: "Enter  to pick Your BirthDay",
                validator: (validator) {
                  if (validator!.isEmpty) {
                    return "please Enter BirthDay";
                  }
                  return null;
                },
                controller: cubit.yearController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
