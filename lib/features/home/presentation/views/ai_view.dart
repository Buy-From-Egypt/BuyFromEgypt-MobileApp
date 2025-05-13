import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/ai_app_bar.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/ai_profile.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/chatting_app_bar.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/enter_message.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/profile_icon.dart';
import 'package:flutter/material.dart';

class AiView extends StatelessWidget {
  AiView({super.key});

  final List<Message> messages = [
    Message(
      isSender: false,
      text:
          'It is a long established fact that a reader will be distracted by the .',
      time: '3:00 PM',
      isAudio: false,
    ),
    Message(
      isSender: true,
      text:
          'It is a long established fact that a reader will be distracted by the .',
      time: '3:00 PM',
      isAudio: false,
    ),
    // Adding a new message from the receiver
    Message(
      isSender: false,
      text: 'This is a new message from the receiver.',
      time: '3:05 PM',
      isAudio: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AiAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount:
                  messages.length + 1, // Added 1 to count the "Today" divider
              itemBuilder: (context, index) {
                if (index == 2) {
                  // Display "Today" before the third message
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text('Today', style: Styles.textStyle13),
                    ),
                  );
                }

                final message =
                    index > 2 ? messages[index - 1] : messages[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: message.isSender
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!message.isSender) ...[
                        const AiProfileIcon(
                          backgroundColor: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Column(
                          crossAxisAlignment: message.isSender
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.6,
                              ),
                              decoration: BoxDecoration(
                                color: message.isAudio
                                    ? const Color(0xFFEAECE1)
                                    : (message.isSender
                                        ? const Color(0xFF5196F3)
                                        : const Color(0xFF3B3C36)),
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(12),
                                  topRight: const Radius.circular(12),
                                  bottomLeft: Radius.circular(
                                      message.isSender ? 12 : 0),
                                  bottomRight: Radius.circular(
                                      message.isSender ? 0 : 12),
                                ),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (!message.isAudio) ...[
                                    Text(
                                      message.isSender
                                          ? 'Company Name'
                                          : 'Export Assistant',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Manrope',
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                  message.isAudio
                                      ? const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.play_arrow_rounded,
                                                color: AppColors.primary,
                                                size: 32),
                                            SizedBox(width: 8),
                                          ],
                                        )
                                      : Text(
                                          message.text,
                                          style: TextStyle(
                                            color: message.isSender
                                                ? Colors.white
                                                : AppColors.c7,
                                            fontSize: 12,
                                            fontFamily: 'Manrope',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(message.time, style: Styles.textStyle12pr),
                          ],
                        ),
                      ),
                      if (message.isSender) ...[
                        const SizedBox(width: 8),
                        const ProfileIcon()
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, -2),
                )
              ],
            ),
            child: const EnterMessage(),
          ),
        ],
      ),
    );
  }
}

class Message {
  final bool isSender;
  final String text;
  final String time;
  final bool isAudio;

  Message({
    required this.isSender,
    required this.text,
    required this.time,
    required this.isAudio,
  });
}
