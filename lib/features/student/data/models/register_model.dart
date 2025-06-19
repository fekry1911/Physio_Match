abstract class RegisterModel {
  final String fullName;
  final String phone;
  final String gender;
  final String status;
  final String dateOfBirth;
  final String city;
  final String imageUrl;
  final String university;
  final String email;

  RegisterModel({
    required this.fullName,
    required this.university,
    required this.status,
    required this.phone,
    required this.gender,
    required this.dateOfBirth,
    required this.city,
    required this.email,
    required this.imageUrl,
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

