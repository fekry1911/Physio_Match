import 'package:add_ques/core/models/user_model.dart';
import 'package:add_ques/features/doctor/data/models/doctor_model.dart';

abstract class UpdateUserRebo{
  Future<String?> UpdateUserImage();
  Future<String?> UpdateUser();
  Future<void> UpdateUserData(DoctorModel userModel);
}