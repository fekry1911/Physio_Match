import 'package:add_ques/features/doctor/presentaion/screens/home_screen/data/models/post_model.dart';

import '../models/center_model.dart';

abstract class GetCenterData{
  Future<List<AdminModel>> getAllCentersData();
  Future<AdminModel>   getCenterData(String uid);
  Future<List<PostModel>> getPostData(String uid);

}