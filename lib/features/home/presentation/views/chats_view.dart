import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:buy_from_egypt/features/home/presentation/views/chatting_view.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/chat_all_messages.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/chat_assisstant.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/chat_show_all.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/chat_unread_section.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/custom_app_bar_market.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/profile_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarMarket(title: 'Chats'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              color: AppColors.c5,
              thickness: 1,
              height: 1,
            ),
            const ExportAssistant(),
            const SizedBox(height: 16),
            const ChatUnreadSection(),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  _buildChatItem(onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChattingView()),
                    );
                  }),
                  _buildChatItem(onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChattingView()),
                    );
                  }),
                  const ShowAllButton(),
                  const SizedBox(height: 16),
                  const AllMessagesTitle(),
                  const SizedBox(height: 8),
                  _buildChatItem(onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChattingView()),
                    );
                  }),
                  _buildChatItem(onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChattingView()),
                    );
                  }),
                  _buildChatItem(onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChattingView()),
                    );
                  }),
                  _buildChatItem(onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChattingView()),
                    );
                  }),
                  _buildChatItem(onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChattingView()),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatItem({required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const ProfileIcon(),

        title: const Text('Mohamed Talaat', style: Styles.textStyle16400),
        subtitle: const Text(
          'Please send me the price of the p....',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Styles.textStyle12c7,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('3:00 PM', style: Styles.textStyle10),
            const SizedBox(height: 4),
            Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Text('2', style: Styles.textStyle9w),
            ),
          ],
        ),
        onTap: onTap, // <---- Added this
      ),
    );
  }
}
