import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/custom_search_bar.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/profile_image.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:buy_from_egypt/features/home/data/services/search_service.dart';
import 'package:buy_from_egypt/features/home/data/models/search_models.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchUser> _searchResults = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _performSearch(_searchController.text);
  }

  Future<void> _performSearch(String keyword) async {
    if (keyword.isEmpty) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
        _error = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final results = await SearchService.searchUsers(keyword: keyword);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load search results: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchBar(
            controller: _searchController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent',
                  style: Styles.textStyle16.copyWith(
                      color: AppColors.danger, fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.history);
                  },
                  child: Text(
                    'See all',
                    style: Styles.textStyle14.copyWith(color: AppColors.c5),
                  ),
                ),
              ],
            ),
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator(
                color: AppColors.primary,
              ))
              : _error != null
                  ? Center(child: Text(_error!))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _searchResults.length,
                        padding: const EdgeInsets.only(bottom: 16),
                        itemBuilder: (context, index) {
                          final user = _searchResults[index];
                          return CustomSearchItem(
                            userName: user.name,
                            userImage: user.profileImage ?? 'assets/images/download.jpeg',
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}

class CustomSearchItem extends StatelessWidget {
  const CustomSearchItem({
    super.key,
    this.trailingWidget,
    required this.userName,
    required this.userImage,
  });
  final Widget? trailingWidget;
  final String userName;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ProfileImage(
                path: userImage,
                width: 48,
                height: 48,
              ),
              const SizedBox(width: 16),
              Text(
                userName,
                style: Styles.textStyle14.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          trailingWidget ??
              const Icon(
                SolarIconsOutline.menuDots,
                size: 24,
                color: AppColors.primary,
              )
        ],
      ),
    );
  }
}