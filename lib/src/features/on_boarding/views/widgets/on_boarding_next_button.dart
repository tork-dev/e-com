import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../common/widgets/buttons/app_buttons.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/on_boarding_controller.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final nextButtonController = OnBoardingController.instance;
    final isDark = AppHelperFunctions.isDarkMode(context);
    return Positioned(
        bottom: AppDeviceUtils.getBottomNavigationBarHeight(),
        right: AppSizes.defaultSpace,
        child: Obx(
          () => AppButtons.smallRoundButton(
            onPressed: () {
              nextButtonController.nextPage();
            },
            buttonColor: isDark ? AppColors.primary : AppColors.dark,
            buttonChild: nextButtonController.currentPageIndex.value == 2
                ? Text(AppLocalizations.of(context)!.start)
                : const Icon(Icons.arrow_forward_ios),
          ),
        ));
  }
}
