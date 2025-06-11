import '../../../../core/models/user_model.dart';

abstract class AddUserData{
  Future<void> addUserData({required UserModel userModel,required userId});

}