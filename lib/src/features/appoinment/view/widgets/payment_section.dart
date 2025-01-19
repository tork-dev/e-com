import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kirei/src/features/appoinment/controller/appointment_controller.dart';

import '../../../../common/widgets/buttons/app_buttons.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/local_storage/local_storage_keys.dart';
import '../../../../utils/local_storage/storage_utility.dart';

class AppointmentPaymentSection extends StatelessWidget {
  const AppointmentPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentController = AppointmentController.instance;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
                width: 150,
                child: RadioListTile(
                  title: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      AppImages.bKashIcon,
                      height: 30,
                    ),
                  ),
                  value: 'bkash',
                  groupValue: appointmentController.paymentMethod.value,
                  activeColor: Colors.black,
                  // Set the active color
                  onChanged: (value) {
                    appointmentController.paymentMethod.value = value!;
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  // Align the icon to the left
                  contentPadding: EdgeInsets.zero, // Remove any padding
                ),
              ),
              const Gap(AppSizes.spaceBtwItems),
              SizedBox(
                height: 30,
                width: 150,
                child: RadioListTile(
                  title: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      AppImages.sslIcon,
                      height: 30,
                    ),
                  ),
                  value: 'ssl',
                  groupValue: appointmentController.paymentMethod.value,
                  activeColor: Colors.black,
                  // Set the active color
                  onChanged: (value) {
                    appointmentController.paymentMethod.value = value!;
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  // Align the icon to the left
                  contentPadding: EdgeInsets.zero, // Remove any padding
                ),
              ),
            ],
          );
        }),
        const Gap(AppSizes.spaceBtwSections),
        AppButtons.largeFlatFilledButton(
            onPressed: (){
              appointmentController.onMakePayment();
            },
            backgroundColor: AppLocalStorage().readData(LocalStorageKeys.activeDoctorAppointment)? AppColors.primary : AppColors.darkGrey,
            buttonText: 'Make payment'.toUpperCase())
      ],
    );
  }
}

