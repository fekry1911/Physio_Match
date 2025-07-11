class AdminModel {
  String? email;
  String? name;
  String? phone;
  String? role;
  String? location;
  String? imageUrl;
  String? uid;
  String? description;

  AdminModel({
    this.email,
    this.name,
    this.role,
    this.location,
    this.phone,
    this.imageUrl,
    this.uid,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'location': location,
      'role': role,
      'imageUrl': imageUrl,
      'uid': uid,
      'description': description,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      imageUrl: map['imageUrl'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      location: map['location'],
      description: map['description'],
      uid: map['uid'],
      role: map['role'],
    );
  }
}
