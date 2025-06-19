import '../../../type_register/data/models/register_model.dart';

class DoctorModel extends RegisterModel {
  final String? exp;
  final String? specialization;
  final String? graduationYear;


  DoctorModel({
    required super.fullName,
    required super.university,
    required super.status,
    required super.phone,
    required super.gender,
    required super.dateOfBirth,
    required super.city,
    required super.email,
    required super.imageUrl,
    required this.specialization,
    required this.exp,
    required this.graduationYear,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      fullName: map['fullName'] ?? '',
      university: map['university'] ?? '',
      status: map['status'] ?? '',
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      city: map['city'] ?? '',
      specialization: map['specialization'],
      exp: map['exp'],
      graduationYear: map['graduationYear'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'university': university,
      'status': status,
      'phone': phone,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'city': city,
      'specialization': specialization,
      'exp': exp,
      'graduationYear': graduationYear,
      'email': email,
      'imageUrl': imageUrl,
    };
  }
}
