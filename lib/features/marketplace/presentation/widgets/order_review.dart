import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/services/product_service.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/comm_item.dart';

class OrderReviewSection extends StatefulWidget {
  final String productId;
  final VoidCallback? onReviewSubmitted;
  const OrderReviewSection({required this.productId, this.onReviewSubmitted, super.key});

  @override
  State<OrderReviewSection> createState() => _OrderReviewSectionState();
}

class _OrderReviewSectionState extends State<OrderReviewSection> {
  List<ProductRating> reviews = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;
  String? errorMessage;
  static const int pageSize = 10;

  // State for new review
  int userRating = 0;
  TextEditingController commentController = TextEditingController();
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _fetchReviews();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  Future<void> _fetchReviews({bool reset = false}) async {
    if (isLoading || !hasMore) return;
    setState(() {
      isLoading = true;
      errorMessage = null;
      if (reset) {
        reviews.clear();
        currentPage = 1;
        hasMore = true;
      }
    });
    try {
      final allReviews = await ProductService.getAllProductReviews(widget.productId);
      final reversedReviews = allReviews.reversed.toList();
      print('All reviews (newest first): $reversedReviews');
      final newReviews = reversedReviews.skip((currentPage - 1) * pageSize).take(pageSize).toList();
      setState(() {
        reviews.addAll(newReviews);
        hasMore = newReviews.length == pageSize;
        currentPage++;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load reviews: \\${e.toString()}';
      });
      debugPrint('Error fetching reviews: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _submitReview() async {
    if (userRating == 0 || commentController.text.trim().isEmpty) return;
    setState(() { isSubmitting = true; });
    try {
      await ProductService.rateProduct(
        productId: widget.productId,
        value: userRating,
        comment: commentController.text.trim(),
      );
      // Refresh reviews and clear input
      await _fetchReviews(reset: true);
      if (widget.onReviewSubmitted != null) {
        widget.onReviewSubmitted!();
      }
      setState(() {
        userRating = 0;
        commentController.clear();
      });
    } catch (e) {
      setState(() { errorMessage = 'Failed to submit review: \\${e.toString()}'; });
    } finally {
      setState(() { isSubmitting = false; });
    }
  }

  double get averageRating {
    if (reviews.isEmpty) return 0;
    return reviews.map((r) => r.userRating).reduce((a, b) => a + b) / reviews.length;
  }

  int get totalReviews => reviews.length;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 327, child: _SectionTitle()),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.c7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _RatingSummaryCard(average: averageRating, total: totalReviews),
              const SizedBox(height: 24),
              // Comment input
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Add your comment', style: Styles.textStyle14b),
              ),
              const SizedBox(height: 8),
              Container(
                height: 90,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.c7),
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white,
                ),
                child: TextField(
                  controller: commentController,
                  maxLines: null,
                  expands: true,
                  style: Styles.textStyle14b,
                  cursorColor: AppColors.primary,
                  decoration: InputDecoration(
                    hintText: 'comment here',
                    hintStyle: Styles.textStyle14c7,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Rate this product ', style: Styles.textStyle14b),
              ),
              const SizedBox(height: 8),
              _InteractiveStarsRow(
                rating: userRating.toDouble(),
                onRatingChanged: (value) {
                  setState(() { userRating = value.toInt(); });
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  onPressed: (userRating == 0 || commentController.text.trim().isEmpty || isSubmitting)
                      ? null
                      : _submitReview,
                  text: isSubmitting ? 'Publishing...' : 'Publish your comment',
                  isLoading: isSubmitting,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const _UsersCommentsTitle(),
        const SizedBox(height: 16),
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(errorMessage!, style: const TextStyle(color: Colors.red)),
          ),
        if (reviews.isEmpty && !isLoading && errorMessage == null)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('No reviews yet.', style: Styles.textStyle14c7),
          ),
        if (reviews.isEmpty && isLoading)
          const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        if (reviews.isNotEmpty)
          ...List.generate(reviews.length, (index) {
            final review = reviews[index];
            return Column(
              children: [
                CommItem(
                  userName: review.userName ?? 'User',
                  date: review.createdAt != null ? review.createdAt!.toLocal().toString().split(' ')[0] : '',
                  rating: review.userRating,
                  comment: review.comment,
                  userProfileImage: review.userProfileImage,
                ),
                if (index < reviews.length - 1) const Divider(),
              ],
            );
          }),
        if (hasMore && !isLoading)
          Center(
            child: TextButton(
              onPressed: _fetchReviews,
              child: const Text('Show more'),
            ),
          ),
        if (isLoading && reviews.isNotEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
          ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Order Reviews',
      style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

class _RatingSummaryCard extends StatelessWidget {
  final double average;
  final int total;
  const _RatingSummaryCard({this.average = 0, this.total = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            average > 0 ? '${average.toStringAsFixed(1)} of 5' : 'No ratings yet',
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 20,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Icon(
                Icons.star,
                size: 13,
                color: index < average.round() ? AppColors.waring : AppColors.c5,
              ),
            )),
          ),
          const SizedBox(height: 8),
          Text(
            total > 0 ? '$total review${total == 1 ? '' : 's'} on this product' : 'No reviews yet',
            style: Styles.textStyle14c7,
          ),
        ],
      ),
    );
  }
}

class _InteractiveStarsRow extends StatelessWidget {
  final double rating;
  final ValueChanged<double> onRatingChanged;
  const _InteractiveStarsRow({required this.rating, required this.onRatingChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () => onRatingChanged(index + 1.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Icon(
                              index < rating
                                  ? Icons.star_rounded
                                  : Icons.star_border_rounded,
                              color: index < rating
                                  ? AppColors.waring
                                  : AppColors.c5,
            ),
          ),
        );
      }),
    );
  }
}

class _UsersCommentsTitle extends StatelessWidget {
  const _UsersCommentsTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
      child: Text(
        'Users comments',
        style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
