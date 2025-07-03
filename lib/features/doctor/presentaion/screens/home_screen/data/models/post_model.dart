class PostModel {
  final String id;
  final String centerName;
  final String imageUrl;
  final String content;
  final String experienceYears;
  final String location;
  final String imagePostUrl;
  final DateTime date;
  final bool isSaved;
  final String? uid;


  PostModel({
    required this.id,
    required this.centerName,
    required this.imageUrl,
    required this.content,
    required this.experienceYears,
    required this.location,
    required this.imagePostUrl,
    required this.date,
    this.uid,
    this.isSaved = false,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      uid: json["uid"] ?? '',
      id: json['id'] ?? '',
      centerName: json['centerName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      content: json['content'] ?? '',
      experienceYears: json['experienceYears'] ?? 0,
      location: json['location'] ?? '',
      imagePostUrl: json['imagePostUrl'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      isSaved: json['isSaved'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'centerName': centerName,
      'imageUrl': imageUrl,
      'content': content,
      'experienceYears': experienceYears,
      'location': location,
      'imagePostUrl': imagePostUrl,
      'date': date.toIso8601String(),
      'isSaved': isSaved,
      "uid":uid
    };
  }
}
