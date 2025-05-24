import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class UserReview extends StatelessWidget {
  final String reviewerName;
  final String reviewText;
  final double rating;
  final int status; // 'Approved', 'Pending', 'Rejected'

  const UserReview({
    super.key,
    required this.reviewerName,
    required this.reviewText,
    required this.rating,
    required this.status,
  });

  Color getStatusColor() {
    switch (status) {
      case 1:
        return Colors.green;
      case 0:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      backgroundColor: AppColors.white,
      width: AppHelperFunctions.screenWidth(),
      padding: EdgeInsets.all(AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reviewer name and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                reviewerName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: getStatusColor().withAlpha(51),
                  borderRadius: BorderRadius.circular(AppSizes.cardRadiusSm),
                ),
                child: Text(
                  status == 1? 'Approved' : 'Pending',
                  style: TextStyle(
                    color: getStatusColor(),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const Gap(AppSizes.sm),
          // Review Text
          Text(
            reviewText,
            style: const TextStyle(fontSize: 14),
          ),
          const Gap(AppSizes.spaceBtwDefaultItems),
          // Rating
          Row(
            children: List.generate(
              5,
                  (index) => Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
