class PostModel {
  final String centerName;
  final String imageUrl;
  final String content;
  final int experienceYears;
  final String location;

  PostModel({
    required this.centerName,
    required this.imageUrl,
    required this.content,
    required this.experienceYears,
    required this.location,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      centerName: json['centerName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      content: json['content'] ?? '',
      experienceYears: json['experienceYears'] ?? 0,
      location: json['location'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'centerName': centerName,
      'imageUrl': imageUrl,
      'content': content,
      'experienceYears': experienceYears,
      'location': location,
    };
  }
}
