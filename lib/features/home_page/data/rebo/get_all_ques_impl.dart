import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'get_all_ques.dart';

class GetAllQuesImpl implements GetAllQues {
  FirebaseFirestore firestore;
  final Set<String> _usedQuestionIds = {}; // IDs already used

  GetAllQuesImpl(this.firestore);

  @override
  Future<List<Map<String, dynamic>>> getAllQues() async {
    final snapshot = await firestore.collection('questions').get();
    List<Map<String, dynamic>> allQuestions =
    snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).where((q) => !_usedQuestionIds.contains(q['id'])).toList();

    allQuestions.shuffle(Random());
    List<Map<String, dynamic>> randomTen = allQuestions.take(10).toList();

    // خزّن الـ IDs المستعملة
    _usedQuestionIds.addAll(randomTen.map((q) => q['id']));

    print(randomTen);
    return randomTen;
  }

}
