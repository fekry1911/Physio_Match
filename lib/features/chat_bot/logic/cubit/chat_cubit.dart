import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../data/models/message_model.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final Dio dio = Dio();

  // ✅ تأكد إن المفتاح مسبوق بـ "Bearer "
  final String apiKey = 'Bearer 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';

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
            'Authorization': apiKey, // تأكد إنه يبدأ بـ Bearer
            'Content-Type': 'application/json',
            'HTTP-Referer': 'https://github.com/fekry1911/docway/blob/development/lib/features/register_screen/presentation/widgets/email_password.dart',
            'X-Title': 'PhysioMatch Assistant',
          },
        ),
        data: {
          "model": "mistralai/mistral-7b-instruct", // أو "mistralai/mistral-7b-instruct" لو شغال معاك
          "messages": [
            {
              "role": "system",
              "content": "أنت مساعد ذكي لدعم أطباء العلاج الطبيعي وتقييم المتقدمين للعمل."
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