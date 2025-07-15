import 'package:cloud_firestore/cloud_firestore.dart';

class RateModel {
  final String userId;
  final String userName;
  final double rating;
  final String? comment;
  final DateTime timestamp;
  final String image;

  RateModel({
    required this.userId,
    required this.userName,
    required this.rating,
    this.comment,
    required this.image,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'rating': rating,
      'comment': comment,
      'timestamp': timestamp.toUtc(),
      'image' : image
    };
  }

  factory RateModel.fromMap(Map<String, dynamic> map) {
    return RateModel(
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      comment: map['comment'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      image: map['image'] ?? '',
    );

}
}
