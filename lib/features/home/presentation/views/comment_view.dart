import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/comment_header.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/comment_item.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/commrnt_input_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentView extends StatelessWidget {
  const CommentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFCDD1D6), // You can adjust this color
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
          ),
          title: const Text(
            'Comments',
            style: TextStyle(
              color: Color(0xFF101623),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Manrope',
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          const CommentHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: 5,
              itemBuilder: (context, index) => const CommentItem(),
            ),
          ),
          const Divider(thickness: 1, height: 1),
          const CommentInputBar(),
        ],
      ),
    );
  }
}
