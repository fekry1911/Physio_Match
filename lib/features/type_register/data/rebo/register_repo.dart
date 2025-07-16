import '../../../doctor/data/models/doctor_model.dart';

abstract class RegisterRepository {
  Future<void> registerDoctor(DoctorModel doctor);
  Future<DoctorModel> getDoctor(String uid);
}
