import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/custom_sell_widget.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/post.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/post/cubit/post_cubit.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/post/cubit/create_post_cubit.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/post/model/post_model.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/post/post_repo_impl.dart';
import 'package:buy_from_egypt/features/home/presentation/views/market_view_ex.dart';
import 'package:buy_from_egypt/features/home/presentation/views/order1_view_ex.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomeBody(),
    MarketViewEx(),
    const Order1ViewEx(),
  ];

  void _onNavTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final postRepo = PostRepoImpl();

    return MultiBlocProvider(
      providers: [
        BlocProvider<PostCubit>(
          create: (_) => PostCubit(postRepo: postRepo)..fetchPosts(),
        ),
        BlocProvider<CreatePostCubit>(
          create: (_) => CreatePostCubit(postRepo: postRepo),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: pages[currentIndex],
        bottomNavigationBar: CustomBottomNavigationBar(
          items: defaultNavItems,
          currentIndex: currentIndex,
          onTap: _onNavTap,
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Column(
      children: [
        const CustomAppBar(),
        const CustomSellWidget(),
        Expanded(
          child: BlocBuilder<PostCubit, List<PostModel>>(
            builder: (context, posts) {
              if (posts.isEmpty) {
                return const Center(child: Text("No posts yet."));
              }

              // ✅ لو في بوستات بتنزل غلط، اعكسيها هنا احتياطيًا
              final sortedPosts = List<PostModel>.from(posts);

              return ListView.builder(
                itemCount: sortedPosts.length,
                itemBuilder: (context, index) {
                  return Post(post: sortedPosts[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
