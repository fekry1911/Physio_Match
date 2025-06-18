import 'package:add_ques/features/student/logic/student_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class StudentRegisterCubit extends Cubit<StudentState> {
  StudentRegisterCubit() : super(StudentInitial());

  TextEditingController nameController=TextEditingController();
  TextEditingController gradeController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController universityController=TextEditingController();
  TextEditingController yearController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController graduationController=TextEditingController();
  TextEditingController specializationController=TextEditingController();
  TextEditingController expController=TextEditingController();
  TextEditingController departmentController=TextEditingController();
  TextEditingController gpaController=TextEditingController();


  int currentStep = 0;

  final formKeys = [
    GlobalKey<FormState>(), // Step 1
    GlobalKey<FormState>(), // Step 2
    GlobalKey<FormState>(), // Step 3
  ];
  String selectedGender = "male";
  bool isSelectedGender=false;

  String selectedStatus = "doctor";
  bool isSelectedStatus=false;

  void changeGender(String gender) {
    selectedGender = gender;
    print(selectedGender);
    isSelectedGender=true;
    emit(StudentGenderChanged());
  }
  void changeStatus(String status) {
    selectedStatus = status;
    print(selectedStatus);
    isSelectedStatus=true;
    emit(StudentGenderChanged());
  }


  // Future<void> submitStudent() async {
  //   final data = {
  //     'name': name,
  //     'phone': phone,
  //     'university': university,
  //     'year': year,
  //     'city': city,
  //     'type': 'student',
  //     'timestamp': FieldValue.serverTimestamp(),
  //   };
  //
  //   await FirebaseFirestore.instance.collection('students').add(data);
  // }

  void nextStep() {
    if (currentStep < 2) {
      currentStep++;
      emit(StudentInitial());
    }
  }
  setCurrentStep(int step){
    currentStep=step;
    emit(SetCurrent());
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      emit(PreviousStep());

    }
  }
  Future<void> selectDate(BuildContext context) async {
    DateTime now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year + 10),
    );

    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        yearController.text = formattedDate;
    }
    emit(PickDateDone());
  }
}