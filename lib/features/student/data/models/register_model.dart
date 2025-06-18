abstract class RegisterModel {
  final String fullName;
  final String phone;
  final String gender;
  final String status;
  final String dateOfBirth;
  final String city;
  final String university;

  RegisterModel({
    required this.fullName,
    required this.university,
    required this.status,
    required this.phone,
    required this.gender,
    required this.dateOfBirth,
    required this.city,
  });

}

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
    required this.specialization,
    required this.exp,
    required this.graduationYear,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
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
    };
  }
}

class StudentModel extends RegisterModel {
  final String? gradeYearGraduate; // السنة الدراسية أو سنة التخرج
  final String? dep;               // القسم
  final String? gpa;               // التقدير العام

  StudentModel({
    required super.fullName,
    required super.university,
    required super.status,
    required super.phone,
    required super.gender,
    required super.dateOfBirth,
    required super.city,
    required this.gradeYearGraduate,
    required this.dep,
    required this.gpa,
  });

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      fullName: map['fullName'] ?? '',
      university: map['university'] ?? '',
      status: map['status'] ?? '',
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      city: map['city'] ?? '',
      gradeYearGraduate: map['gradeYearGraduate'],
      dep: map['dep'],
      gpa: map['gpa'],
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
    };
  }
}

