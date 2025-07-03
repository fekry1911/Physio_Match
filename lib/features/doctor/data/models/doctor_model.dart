import '../../../type_register/data/models/register_model.dart';

class DoctorModel extends RegisterModel {
  int? tries = 3;
  final String? uid;


  DoctorModel({
    super.fullName,
    super.university,
    super.phone,
    super.gender,
    super.dateOfBirth,
    super.city,
    super.email,
    super.imageUrl,
    super.specialization,
    this.tries,
    super.resume,
    this.uid,

  });

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      tries: map['tries'] ?? 3,
      specialization: map['specialization'] ?? '',
      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      fullName: map['fullName'] ?? '',
      university: map['university'] ?? '',
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      city: map['city'] ?? '',
      resume: map['resume'],
      uid: map['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'specialization': specialization,
      'fullName': fullName,
      'university': university,
      'phone': phone,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'city': city,
      'email': email,
      'imageUrl': imageUrl,
      'tries': tries,
      'resume': resume,
      'uid': uid,
    };
  }
}
