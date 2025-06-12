class UserModel {
  final String name;
  final String email;
  final String phone;
  final String imageUrl;
  final int tries;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.imageUrl,
    required this.tries,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'imageUrl': imageUrl,
      'tries': tries,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      tries: map['tries'] ?? 0,
      name: map['name'] ?? ''?? "",
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
