import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:add_ques/features/type_register/data/rebo/register_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../doctor/data/models/doctor_model.dart';
import '../../../student/daya/models/student_model.dart';
import '../models/register_model.dart';

class RegisterRepoImpl implements RegisterRepository {
  FirebaseFirestore firestore;

  RegisterRepoImpl(this.firestore);


  @override
  Future<void> registerDoctor(DoctorModel doctor) async {
    await firestore.collection('doctors').doc(CacheHelper.getString(key: "uid")).set(doctor.toMap());
  }

  @override
  Future<void> registerStudent(StudentModel student) async {
    await firestore.collection('students').doc(CacheHelper.getString(key: "uid")).set(student.toMap());
  }

  @override
  Future<DoctorModel> getDoctor(String uid) async {
    var response = await firestore.collection('doctors').where(
        'uid', isEqualTo: uid).get();
    return DoctorModel.fromMap(response.docs.first.data());
  }

  @override
  Future<StudentModel> getStudent(String uid) async {
    var response = await firestore.collection('students').where(
        'uid', isEqualTo: uid).get();
    return StudentModel.fromMap(response.docs.first.data());
  }
}