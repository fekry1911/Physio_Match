import '../models/register_model.dart';

abstract class RegisterRepository {
  Future<void> registerDoctor(DoctorModel doctor);
  Future<void> registerStudent(StudentModel student);
  Future<DoctorModel> getDoctor(String uid);
  Future<StudentModel> getStudent(String uid);
}
