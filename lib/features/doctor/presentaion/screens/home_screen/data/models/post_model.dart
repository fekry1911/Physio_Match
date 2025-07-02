class PostModel {
  final String id;
  final String centerName;
  final String imageUrl;
  final String content;
  final String experienceYears;
  final String location;
  final String imagePostUrl;
  final DateTime date;

  PostModel({
    required this.id,
    required this.centerName,
    required this.imageUrl,
    required this.content,
    required this.experienceYears,
    required this.location,
    required this.imagePostUrl,
    required this.date,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? '',
      centerName: json['centerName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      content: json['content'] ?? '',
      experienceYears: json['experienceYears'] ?? 0,
      location: json['location'] ?? '',
      imagePostUrl: json['imagePostUrl'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
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
    };
  }
}
