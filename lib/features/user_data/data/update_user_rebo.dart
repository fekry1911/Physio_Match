import 'package:add_ques/core/models/user_model.dart';

abstract class UpdateUserRebo{
  Future<String?> UpdateUserImage();
  Future<String?> UpdateUser();
  Future<void> UpdateUserData(UserModel userModel);
}