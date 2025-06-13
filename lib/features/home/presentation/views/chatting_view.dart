import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/chatting_app_bar.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/enter_message.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/profile_icon.dart';
import 'package:flutter/material.dart';

class ChattingView extends StatelessWidget {
  ChattingView({super.key});

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
    Message(
      isSender: false,
      text: '',
      time: '3:00 PM',
      isAudio: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ChattingAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: message.isSender
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!message.isSender) ...[
                        const ProfileIcon(),
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
                                        : const Color(0xFFEAECE1)),
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
                                      'Company Name',
                                      style: TextStyle(
                                        color: message.isSender
                                            ? AppColors.white
                                            : AppColors.primary,
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
                                            AudioWaveform(),
                                          ],
                                        )
                                      : Text(
                                          message.text,
                                          style: TextStyle(
                                            color: message.isSender
                                                ? Colors.white
                                                : Colors.black,
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

class AudioWaveform extends StatelessWidget {
  const AudioWaveform({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(10, (index) {
        return Container(
          width: 3,
          height: (index.isEven ? 18 : 10).toDouble(),
          margin: const EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
