import '../../../type_register/data/models/register_model.dart';

class StudentModel extends RegisterModel {
  final String? gradeYearGraduate; // السنة الدراسية أو سنة التخرج
  final String? dep;               // القسم
  final String? gpa;
  final int? tries;



  StudentModel({
    required super.fullName,
    required super.university,
    required super.status,
    required super.phone,
    required super.gender,
    required super.dateOfBirth,
    required super.city,
    required super.email,
    required super.imageUrl,
    required this.gradeYearGraduate,
    required this.dep,
    required this.gpa,
    required this.tries,
  });

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      email: map['email'] ?? '',

      fullName: map['fullName'] ?? '',
      tries: map['tries'],
      university: map['university'] ?? '',
      status: map['status'] ?? '',
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      city: map['city'] ?? '',
      gradeYearGraduate: map['gradeYearGraduate'],
      dep: map['dep'],
      gpa: map['gpa'],
      imageUrl: map['imageUrl'],
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
      'gradeYearGraduate': gradeYearGraduate,
      'dep': dep,
      'gpa': gpa,
      'tries': tries,
      'imageUrl': imageUrl,
    };
  }
}
