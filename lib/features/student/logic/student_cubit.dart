import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:add_ques/features/student/logic/student_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../data/models/register_model.dart';
import '../data/rebo/register_repo.dart';

class StudentRegisterCubit extends Cubit<StudentState> {
  StudentRegisterCubit(this.registerRepository,this.auth) : super(StudentInitial());
  FirebaseAuth auth ;
  RegisterRepository registerRepository;
  TextEditingController nameController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController graduationController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController gpaController = TextEditingController();

  int currentStep = 0;

  final formKeys = [
    GlobalKey<FormState>(), // Step 1
    GlobalKey<FormState>(), // Step 2
    GlobalKey<FormState>(), // Step 3
  ];
  String selectedGender = "male";
  bool isSelectedGender = false;

  String selectedStatus = "doctor";
  bool isSelectedStatus = false;

  void changeGender(String gender) {
    selectedGender = gender;
    print(selectedGender);
    isSelectedGender = true;
    emit(StudentGenderChanged());
  }

  void changeStatus(String status) {
    selectedStatus = status;
    print(selectedStatus);
    isSelectedStatus = true;
    emit(StudentGenderChanged());
  }

  Future<void> submitStudent() async {
    emit(StudentSubmitLoading());
   try{
     if (selectedStatus == "Doctor") {
       await registerRepository.registerDoctor(
         DoctorModel(
           fullName: nameController.text,
           university: universityController.text,
           status: selectedStatus,
           phone: phoneController.text,
           gender: selectedGender,
           dateOfBirth: yearController.text,
           city: cityController.text,
           specialization: specializationController.text,
           exp: expController.text,
           graduationYear: graduationController.text,
           email: auth.currentUser!.email!,
           imageUrl: 'http://i0.wp.com/digitalhealthskills.com/wp-content/uploads/2022/11/3da39-no-user-image-icon-27.png?fit=500%2C500&ssl=1',
         ),
       );
       CacheHelper.putString(key: "type", value: "doctor");

     } else {
       await registerRepository.registerStudent(
         StudentModel(
           fullName: nameController.text,
           university: universityController.text,
           status: selectedStatus,
           phone: phoneController.text,
           gender: selectedGender,
           dateOfBirth: yearController.text,
           city: cityController.text,
           gradeYearGraduate: gradeController.text,
           dep: departmentController.text,
           gpa: gpaController.text,
           email: auth.currentUser!.email!,
           imageUrl: 'http://i0.wp.com/digitalhealthskills.com/wp-content/uploads/2022/11/3da39-no-user-image-icon-27.png?fit=500%2C500&ssl=1',
           tries: 3,
         ),
       );
       CacheHelper.putString(key: "type", value: "student");

     }
     CacheHelper.putBoolean(key: "submitted", value: true);
     emit(StudentSubmitted());
   }catch(e){
     print(e.toString());
     emit(StudentSubmitFailed(error: e.toString()));
   }
  }

  void nextStep() {
    if (currentStep < 2) {
      currentStep++;
      emit(StudentInitial());
      if(currentStep==2){
        submitStudent();
      }
    }
    if(currentStep==2){
      submitStudent();
    }
  }

  setCurrentStep(int step) {
    currentStep = step;
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
