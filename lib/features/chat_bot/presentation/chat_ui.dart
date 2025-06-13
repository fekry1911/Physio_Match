import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:add_ques/core/shared_widgets/shared_text_form_field.dart';
import 'package:add_ques/core/theme/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/const/const.dart';
import '../../../core/theme/text_themes/text.dart';
import '../logic/cubit/chat_cubit.dart';
import '../logic/cubit/chat_state.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.pushAndRemoveUntil(homeScreen);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:  Text("Physio AI Assistant",style: TextThemes.font22BlackMedium,),
          backgroundColor: AppColors.mainTealColor,
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              final messages =
              state is ChatLoaded
                  ? state.messages
                  : context.read<ChatCubit>().messages;

              if (messages.isEmpty) {
                return Center(
                  child: Text(
                    "ابدأ الدردشة الآن ✨",
                    style: TextThemes.font16BlackBold.copyWith(color: AppColors.mainTealColor),
                  ),
                );
              }

              return ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(10),
                itemCount: messages.length,
                itemBuilder: (_, index) {
                  final msg = messages[messages.length - 1 - index];
                  return Align(
                    alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: msg.isUser ? AppColors.mainTealColor : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        msg.text,
                        style: TextStyle(
                          color: msg.isUser ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            ),

            ),
            Container(
              margin: EdgeInsets.only(bottom: 25.h, left: 10.w, right: 10.w),
              child: Row(
                children: [
                  Expanded(
                    child: SharedTextFormField(
                      hintText: "اكتب سؤالك...",
                      validator: (_)=>null,
                      controller: controller,
                    ),
                  ),
                   SizedBox(width: 8.w),
                  IconButton(
                    icon:  Icon(Icons.send,size: 20.r,),
                    color: AppColors.mainTealColor,
                    onPressed: () {
                      final msg = controller.text.trim();
                      if (msg.isNotEmpty) {
                        context.read<ChatCubit>().sendMessage(msg);
                        controller.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
