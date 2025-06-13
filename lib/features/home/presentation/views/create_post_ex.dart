import 'package:buy_from_egypt/features/home/presentation/view_model/post/cubit/create_post_cubit.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/post/cubit/create_post_state.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/post/cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/custom_buttom_bar.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/post_bottom_sheet.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/user_section.dart';

class CreatePostEx extends StatefulWidget {
  const CreatePostEx({super.key});

  @override
  State<CreatePostEx> createState() => _CreatePostExState();
}

class _CreatePostExState extends State<CreatePostEx> {
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

  void _clearInput() {
    _controller.clear();
    context.read<CreatePostCubit>().onDescriptionChanged("");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreatePostCubit(),
      child: Builder(
        builder: (context) => GestureDetector(
          onTap: _requestKeyboardFocus,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: const BackButton(),
              title: const Text('Create Post', style: Styles.textStyle16bl),
              elevation: 0,
              backgroundColor: Colors.white,
              actions: [
                BlocConsumer<CreatePostCubit, CreatePostState>(
                  listener: (context, state) {
                    if (state is CreatePostSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Post created successfully')),
                      );
                      _clearInput();
                      Navigator.pop(context); // ✅ ارجعي بعد ما يتسجل البوست
                    } else if (state is CreatePostError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextButton(
                        onPressed: state is CreatePostLoading
                            ? null
                            : () => context
                                .read<CreatePostCubit>()
                                .submitPost(context),
                        child: state is CreatePostLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text("Post", style: Styles.textStyle14b),
                      ),
                    );
                  },
                ),
              ],
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16),
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
                          onChanged: (val) => context
                              .read<CreatePostCubit>()
                              .onDescriptionChanged(val),
                        ),
                      ),
                      SizedBox(
                        height: _isBottomSheetVisible
                            ? 200.0 + MediaQuery.of(context).viewInsets.bottom
                            : 60.0 + MediaQuery.of(context).viewInsets.bottom,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: CustomBottomBar(onExpandLessTap: _toggleBottomSheet),
                ),
                if (_isBottomSheetVisible)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    child: const AddToPostBottomSheet(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
