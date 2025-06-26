abstract class RegisterModel {
  final String? fullName;
  final String? phone;
  final String? gender;
  final String? dateOfBirth;
  final String? city;
  final String? imageUrl;
  final String? university;
  final String? email;
  final String? resume;
  final String? specialization;

  RegisterModel({
    this.specialization,
    this.resume,
    this.fullName,
    this.university,
    this.phone,
    this.gender,
    this.dateOfBirth,
    this.city,
    this.email,
    this.imageUrl,
  });
}
