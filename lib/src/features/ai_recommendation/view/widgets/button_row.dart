import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class ButtonRow extends StatelessWidget {
  final VoidCallback onTapNext;
  const ButtonRow({
    super.key, required this.onTapNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 120,
                color: AppColors.white,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                      color: AppColors.secondary,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Back',
                      style: TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold),
                    ),


                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: InkWell(
              onTap: onTapNext,
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 120,
                color: AppColors.secondary,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'NEXT',
                      style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}