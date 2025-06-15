import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../../core/const/keys/aoi_keys.dart';
import '../../data/models/message_model.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final Dio dio = Dio();

  final String apiKey1 = apiKey;


  List<Message> messages = [];

  ChatCubit() : super(ChatInitial());

// chat_cubit.dart
// ... (imports and class definition)

  Future<void> sendMessage(String userMessage) async {
    messages.add(Message(text: userMessage, isUser: true));
    // نضيف رسالة "..." مؤقتة
    messages.add(Message(text: '...', isUser: false));
    emit(ChatLoaded(List.from(messages)));

    try {
      final response = await dio.post(
        'https://openrouter.ai/api/v1/chat/completions',
        options: Options(
          headers: {
            'Authorization': apiKey1, // تأكد إنه يبدأ بـ Bearer
            'Content-Type': 'application/json',
            'HTTP-Referer': 'https://github.com/fekry1911/Physio_Match',
            'X-Title': 'PhysioMatch Assistant',
          },
        ),
        data: {
          "model": "mistralai/mistral-7b-instruct", // أو "mistralai/mistral-7b-instruct" لو شغال معاك
          "messages": [
            {
              "role": "system",
              "content": "You are a professional medical assistant specialized in physical therapy. Your task is to provide accurate and helpful information to doctors and patients based on the latest medical and scientific recommendations. Do not give final diagnoses, but offer informative support only."
            },
            {
              "role": "user",
              "content": userMessage
            }
          ]
        },
      );

      messages.removeLast();
      final reply = response.data['choices'][0]['message']['content'];
      messages.add(Message(text: reply, isUser: false));
      emit(ChatLoaded(List.from(messages)));
    } catch (e) {
      messages.removeLast(); // نشيل "..." في حالة الخطأ

      print('❌ Error: $e');
      if (e is DioException) {
        print('  DioException Details:');
        print('    Type: ${e.type}');
        print('    Message: ${e.message}');
        print('    StatusCode: ${e.response?.statusCode}');
        print('    ResponseData: ${e.response?.data}');
        print('    RequestPath: ${e.requestOptions.path}');
        print('    RequestData: ${e.requestOptions.data}');
        print('    RequestHeaders: ${e.requestOptions.headers}');
      }

      messages.add(Message(text: '❌ حدث خطأ أثناء الاتصال بـ OpenRouter.', isUser: false));
      emit(ChatLoaded(List.from(messages)));
    }
  }
}