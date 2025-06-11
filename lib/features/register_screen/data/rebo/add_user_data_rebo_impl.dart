import 'package:add_ques/core/models/user_model.dart';
import 'package:add_ques/features/register_screen/data/rebo/add_user_data_rebo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUserDataImpl implements AddUserData{
  FirebaseFirestore firestore ;
  AddUserDataImpl(this.firestore);
  @override
  Future<void> addUserData({required UserModel userModel,required userId}) async {
    await firestore.collection('users').doc(userId).set(userModel.toMap());

  }
}