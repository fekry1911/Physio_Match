import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:add_ques/features/type_register/data/rebo/register_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../doctor/data/models/doctor_model.dart';

class RegisterRepoImpl implements RegisterRepository {
  FirebaseFirestore firestore;

  RegisterRepoImpl(this.firestore);


  @override
  Future<void> registerDoctor(DoctorModel doctor) async {
    await firestore.collection('doctors').doc(CacheHelper.getString(key: "uid")).set(doctor.toMap());
  }


  @override
  Future<DoctorModel> getDoctor(String uid) async {
    var response = await firestore.collection('doctors').where(
        'uid', isEqualTo: uid).get();
    return DoctorModel.fromMap(response.docs.first.data());
  }

}