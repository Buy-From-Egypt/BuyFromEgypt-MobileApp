// create_post.dart

import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/custom_post_app_bar.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/post_bottom_sheet.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/user_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  bool _isBottomSheetVisible = false;

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _requestKeyboardFocus() {
    FocusScope.of(context).requestFocus(_focusNode);
  }

  void _toggleBottomSheet() {
    setState(() {
      _isBottomSheetVisible = !_isBottomSheetVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _requestKeyboardFocus,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: const CustomPostAppBar(),
        body: Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UserSection(),
                  const SizedBox(height: 10),
                  Expanded(
                    child: TextField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintText: 'What are you selling?',
                        border: InputBorder.none,
                        hintStyle: Styles.textStyle14c5,
                      ),
                      focusNode: _focusNode,
                      controller: _controller,
                      style: Styles.textStyle14,
                    ),
                  ),
                  SizedBox(
                      height: _isBottomSheetVisible
                          ? 200.0 +
                              MediaQuery.of(context)
                                  .viewInsets
                                  .bottom // Adjust for bottom sheet height + keyboard
                          : 60.0 +
                              MediaQuery.of(context)
                                  .viewInsets
                                  .bottom), // Adjust for bottom bar + keyboard
                ],
              ),
            ),
            // Floating bottom bar
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomBottomBar(onExpandLessTap: _toggleBottomSheet),
            ),
            // Bottom Sheet
            if (_isBottomSheetVisible)
              Positioned(
                left: 0,
                right: 0,
                bottom: MediaQuery.of(context)
                    .viewInsets
                    .bottom, // Appear above the keyboard
                child: const AddToPostBottomSheet(),
              ),
          ],
        ),
      ),
    );
  }
}

class CustomBottomBar extends StatelessWidget {
  final VoidCallback onExpandLessTap;

  const CustomBottomBar({super.key, required this.onExpandLessTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      color: Colors.white,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: AppColors.c4, width: 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const SvgIcon(
                  path: 'assets/images/black image.svg',
                  width: 28.67,
                  height: 28.67),
              const SizedBox(width: 10),
              const SvgIcon(
                  path: 'assets/images/black video.svg',
                  width: 28.67,
                  height: 28.67),
              const SizedBox(width: 10),
              const SvgIcon(
                  path: 'assets/images/black calendar.svg',
                  width: 31,
                  height: 31),
              const SizedBox(width: 10),
              const SvgIcon(
                  path: 'assets/images/Black link.svg', width: 17, height: 17),
              const Spacer(),
              GestureDetector(
                onTap: onExpandLessTap,
                child: Icon(
                  Icons.expand_less_rounded,
                  size: 40,
                  color: AppColors.c5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
