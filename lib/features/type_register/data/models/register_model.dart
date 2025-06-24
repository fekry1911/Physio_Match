abstract class RegisterModel {
  final String fullName;
  final String phone;
  final String gender;
  final String dateOfBirth;
  final String city;
  final String imageUrl;
  final String university;
  final String email;
  final String resume;

  RegisterModel({
    required this.resume,
    required this.fullName,
    required this.university,
    required this.phone,
    required this.gender,
    required this.dateOfBirth,
    required this.city,
    required this.email,
    required this.imageUrl,
  });
}
