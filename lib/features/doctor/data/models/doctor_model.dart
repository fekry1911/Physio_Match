import '../../../type_register/data/models/register_model.dart';

class DoctorModel extends RegisterModel {
  int tries = 3;


  DoctorModel({
    required super.fullName,
    required super.university,
    required super.phone,
    required super.gender,
    required super.dateOfBirth,
    required super.city,
    required super.email,
    required super.imageUrl,
    required this.tries, required super.resume,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      tries: map['tries'] ?? 3,
      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      fullName: map['fullName'] ?? '',
      university: map['university'] ?? '',
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      city: map['city'] ?? '',
      resume: map['resume'] ,

    );
  }

  Map<String, dynamic> toMap() {
    return {
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
    };
  }
}
