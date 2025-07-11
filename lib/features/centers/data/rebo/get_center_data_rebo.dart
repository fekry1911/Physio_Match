import 'package:add_ques/features/centers/data/models/center_model.dart';

import 'package:add_ques/features/doctor/presentaion/screens/home_screen/data/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'get_center_data.dart';

class GetCenterDataImpl extends GetCenterData{
  FirebaseFirestore firebaseFirestore;
  GetCenterDataImpl(this.firebaseFirestore);
  @override
  Future<List<AdminModel>> getAllCentersData() async {
    List<AdminModel> adminList = [];
    try{
     var result =await firebaseFirestore.collection('admins').get();
     result.docs.forEach((element) {
       adminList.add(AdminModel.fromMap(element.data()));
     });
     return adminList;
    }
        catch(e){
      return adminList;
        }
  }

  @override
  Future<List<PostModel>> getPostData() {
    // TODO: implement getPostData
    throw UnimplementedError();
  }

  @override
  Future<AdminModel> getCenterData(String uid) async {
    try{
      var result =await firebaseFirestore.collection('admins').doc(uid).get();
      return AdminModel.fromMap(result.data()!);
    }
        catch(e){
      return AdminModel();
        }
  }
}