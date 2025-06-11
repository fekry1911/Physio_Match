class SignModel {
  final String email;
  final String password;


  SignModel({
    required this.email,
    required this.password,

  });

  Map<String, dynamic> toMap() {
    return {
      'name': email,
      'email': password,
    };
  }

}
