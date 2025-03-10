import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:kirei/src/features/appoinment/controller/appointment_controller.dart';
import 'package:kirei/src/features/appoinment/view/widgets/appointment_forms.dart';
import 'package:kirei/src/features/appoinment/view/widgets/payment_section.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../../common/widgets/containers/banner_image.dart';
import '../../../utils/local_storage/local_storage_keys.dart';
import '../../../utils/local_storage/storage_utility.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentController = Get.put(AppointmentController());
    return AppLayoutWithDrawer(
        isFromOtherPage: true,
        backToHome: true,
        backgroundColor: AppColors.white,
        globalKey: appointmentController.appointmentKey,
        title: const Text(
          'Dr. Appointment',
          style: TextStyle(color: AppColors.backLayoutAppBarTitle),
        ),
        centerTitle: true,
        leadingIconColor: AppColors.darkGrey,
        bodyBackgroundColor: Colors.grey[100],
        padding: 0,
        bottomNav: const AppointmentPaymentSection(),
        body: ListView(
          children: [
            AppBannerImage(
              height: 150,
              width: AppHelperFunctions.screenWidth(),
              fit: BoxFit.cover,
              isNetworkImage: true,
              imgUrl: AppLocalStorage().readData(LocalStorageKeys.doctorAppointmentBanner),
              applyPadding: false,
              applyImageRadius: false,
            ),
            const Gap(AppSizes.md),
            const AppAppointmentForms(),
            const Gap(AppSizes.md),
          ],
        ));
  }
}
