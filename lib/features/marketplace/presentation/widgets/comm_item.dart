import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';

Widget rateingStar({
  required BuildContext context,
  required double rating,
  required int itemCount,
  required double itemSize,
  required Color unratedColor,
  required IndexedWidgetBuilder itemBuilder,
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(itemCount, (index) {
      return Icon(
        Icons.star,
        color: index < rating ? (itemBuilder(context, index) as Icon).color : unratedColor,
        size: itemSize,
      );
    }),
  );
}

class CommItem extends StatelessWidget {
  final String userName;
  final String date;
  final int rating;
  final String comment;
  final String? userProfileImage;
  const CommItem({
    super.key,
    required this.userName,
    required this.date,
    required this.rating,
    required this.comment,
    this.userProfileImage,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header: Avatar, Name, Date
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: userProfileImage != null && userProfileImage!.isNotEmpty
                  ? NetworkImage(userProfileImage!)
                  : const AssetImage('assets/images/theo.jpeg') as ImageProvider,
            ),
            SizedBox(width: width * 0.025),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(userName, style: Styles.textStyle14pr),
                    const SizedBox(width: 8),
                    Text(date, style: Styles.textStyle12700),
                  ],
                ),
                SizedBox(height: width * 0.01),
                rateingStar(
                  context: context,
                  rating: rating.toDouble(),
                  itemCount: 5,
                  itemSize: width * 0.05,
                  unratedColor: AppColors.waring.withOpacity(0.3),
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: AppColors.waring),
                ),
              ],
            ),
          ],
        ),

        // Comment content
        SizedBox(height: width * 0.02),
        Text(
          comment,
          style: Styles.textStyle14pr,
        ),
      ],
    );
  }
}
