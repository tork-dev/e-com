import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/appoinment/controller/appointment_controller.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/local_storage/local_storage_keys.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import 'appointment_form_widget.dart';

class AppAppointmentForms extends StatelessWidget {
  const AppAppointmentForms({super.key});

  @override
  Widget build(BuildContext context) {
    AppointmentController appointmentController = AppointmentController.instance;
    return ListView(
      shrinkWrap: true,
      children: [
        Visibility(
          visible: !AppLocalStorage().readData(LocalStorageKeys.activeDoctorAppointment),
          child: AppCardContainer(
            backgroundColor: AppColors.primary.withOpacity(.7),
            applyRadius: false,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.md),
              child: Center(child: Text('Doctor appointment is currently unavailable!', style: Theme.of(context).textTheme.bodyLarge!.apply(color: AppColors.white),))),
        ),
         AppAppointmentFormWidget(
          controller: appointmentController.fullNameController,
            labelText: 'Full Name*'),
         AppAppointmentFormWidget(
           controller: appointmentController.ageController,
             labelText: 'Age*'),
         AppAppointmentFormWidget(
           controller: appointmentController.contactNumberController,
             labelText: 'Contact Number*'),
         AppAppointmentFormWidget(
           controller: appointmentController.whatsAppNumberController,
             labelText: 'WhatsApp Number*'),
        TextFormField(
          keyboardType: TextInputType.multiline,
          minLines: 4,
          maxLines: 8,
          cursorColor: AppColors.primary,
          controller: appointmentController.problemController,
          decoration:  InputDecoration(
            enabled: AppLocalStorage().readData(LocalStorageKeys.activeDoctorAppointment),
              labelText: 'Problem *',
              labelStyle: Theme.of(context).textTheme.bodySmall,
              floatingLabelStyle: const TextStyle(color: AppColors.primary),
              hintText: 'Describe your problem here...',
              hintStyle: const TextStyle(color: AppColors.darkGrey),
              focusedBorder: const UnderlineInputBorder(
                  borderSide:
                  BorderSide(color: AppColors.primary, width: 2))),
          validator: (v) {
            if (v!.trim().isEmpty) {
              return 'Please enter something';
            }
            return null;
          },
        ),
        const Gap(AppSizes.spaceBtwDefaultItems),
        const Text('Appointment Fee: 499 BDT', style: TextStyle(color: AppColors.warning),),
        Obx(() {
            return Column(
              children: [
                RadioListTile(
                  title: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.network(
                      'https://app.kireibd.com/assets/img/cards/bkash.png',
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
                RadioListTile(
                  title: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.network(
                      'https://app.kireibd.com/assets/img/cards/sslcommerz.png',
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
              ],
            );
          }
        ),
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

