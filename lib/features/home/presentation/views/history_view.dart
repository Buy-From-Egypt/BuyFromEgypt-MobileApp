import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/home/presentation/views/search_view.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/custom_back_button.dart';
import 'package:buy_from_egypt/features/home/data/services/search_service.dart';
import 'package:buy_from_egypt/features/home/data/models/search_models.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<SearchHistoryItem> _historyItems = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  Future<void> _loadSearchHistory() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final history = await SearchService.getSearchHistory();
      setState(() {
        _historyItems = history;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load search history: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _clearAllHistory() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await SearchService.clearSearchHistory();
      _loadSearchHistory(); // Reload history after clearing
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Search history cleared!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to clear search history: $e')),
      );
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
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        toolbarHeight: 52,
        leading: const Padding(
          padding: EdgeInsets.only(left: 24.0),
          child: CustomBackButton(),
        ),
        title: Text(
          'History',
          style: Styles.textStyle18.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: _clearAllHistory,
              child: Text(
                'Clear all',
                style: Styles.textStyle14.copyWith(color: AppColors.danger),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          _isLoading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()))
              : _error != null
                  ? Expanded(
                      child: Center(child: Text(_error!)),
                    )
                  : Expanded(
                      child: _historyItems.isEmpty
                          ? const Center(child: Text('No search history yet.'))
                          : ListView.builder(
                              itemCount: _historyItems.length,
                              padding: const EdgeInsets.only(bottom: 16),
                              itemBuilder: (context, index) {
                                final item = _historyItems[index];
                                return CustomSearchItem(
                                  userName: item.query, // Displaying the query as the name
                                  userImage: 'assets/images/samsun.png', // Placeholder image
                                  trailingWidget: GestureDetector(
                                    onTap: () {
                                      // TODO: Implement delete single history item
                                      print('Delete history item: ${item.id}');
                                    },
                                    child: const Icon(
                                      SolarIconsOutline.closeCircle,
                                      size: 24,
                                      color: AppColors.c5,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
        ],
      ),
    );
  }
}