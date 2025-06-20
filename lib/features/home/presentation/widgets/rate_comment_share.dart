import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_cubit.dart';
import 'package:buy_from_egypt/features/home/presentation/views/comment_view_im.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RateCommentShare extends StatelessWidget {
  final String postId;
  const RateCommentShare({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildActionButton('assets/images/star.svg', 'Rate'),
              const SizedBox(width: 16),
              ActionButton(
                imagePath: 'assets/images/Chat Unread.svg',
                label: 'Comment',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) =>
                            CommentCubit.create()..fetchComments(postId),
                        child: CommentViewIm(postId: postId),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          _buildShareButton(),
        ],
      ),
    );
  }

  Widget _buildActionButton(String imagePath, String label) {
    return Row(
      children: [
        SvgPicture.asset(imagePath, height: 18, width: 18),
        const SizedBox(width: 8),
        Text(label,
            style: const TextStyle(
              color: Color(0xFF3B3C36),
              fontSize: 12,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
            )),
      ],
    );
  }

  Widget _buildShareButton() {
    return Container(
      width: 40,
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: SizedBox(
          height: 18,
          width: 18,
          child: SvgPicture.asset('assets/images/right up.svg'),
        ),
      ),
    );
  }
}
