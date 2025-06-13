import 'package:dio/dio.dart';

class GeminiService {
  final Dio dio = Dio();
  final String apiKey = 'AIzaSyA5KYh3kEwrOEMxOh_DchoXGTGv6BSD3lo'; // استبدله بمفتاحك الحقيقي

  Future<String> sendToGemini(String userMessage) async {
    final url = 'https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key=$apiKey';

    final body = {
      "contents": [
        {
          "parts": [
            {"text": userMessage}
          ]
        }
      ]
    };

    try {
      final response = await dio.post(
        url,
        data: body,
        options: Options(headers: {
          "Content-Type": "application/json",
        }),
      );

      final reply = response.data['candidates'][0]['content']['parts'][0]['text'];
      return reply;
    } catch (e) {
      print('❌ Gemini Error: $e');
      return 'حدث خطأ أثناء الاتصال بـ Gemini.';
    }
  }
}
