import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/appointment/controller/appointment_controller.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/local_storage/local_storage_keys.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import 'appointment_form_widget.dart';

class AppAppointmentForms extends StatelessWidget {
  const AppAppointmentForms({super.key});

  @override
  Widget build(BuildContext context) {
    AppointmentController appointmentController =
        AppointmentController.instance;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: Column(
        children: [
          Visibility(
            visible:
                !AppLocalStorage().readData(
                  LocalStorageKeys.activeDoctorAppointment,
                ),
            child: AppCardContainer(
              backgroundColor: AppColors.primary.withAlpha((0.7 * 255).toInt()),
              applyRadius: false,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.md,
                vertical: AppSizes.md,
              ),
              child: Center(
                child: Text(
                  'Doctor appointment is currently unavailable!',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.apply(color: AppColors.white),
                ),
              ),
            ),
          ),
          AppAppointmentFormWidget(
            controller: appointmentController.fullNameController,
            labelText: 'Full Name*',
            inputType: TextInputType.text,
          ),
          Gap(AppSizes.spaceBtwInputFields),
          AppAppointmentFormWidget(
            controller: appointmentController.ageController,
            labelText: 'Age*',
            inputType: TextInputType.number,
          ),
          Gap(AppSizes.spaceBtwInputFields),
          AppAppointmentFormWidget(
            controller: appointmentController.contactNumberController,
            labelText: 'Contact Number*',
            inputType: TextInputType.number,
          ),
          Gap(AppSizes.spaceBtwInputFields),
          AppAppointmentFormWidget(
            controller: appointmentController.whatsAppNumberController,
            labelText: 'WhatsApp Number*',
            inputType: TextInputType.number,
          ),
          Gap(AppSizes.spaceBtwInputFields),
          TextFormField(
            keyboardType: TextInputType.multiline,
            minLines: 4,
            maxLines: 8,
            cursorColor: AppColors.primary,
            controller: appointmentController.problemController,
            decoration: InputDecoration(
              enabled: AppLocalStorage().readData(
                LocalStorageKeys.activeDoctorAppointment,
              ),
              labelText: 'Problem *',
              labelStyle: Theme.of(context).textTheme.bodySmall,
              floatingLabelStyle: const TextStyle(color: AppColors.primary),
              hintText: 'Describe your problem here...',
              hintStyle: const TextStyle(color: AppColors.darkGrey),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
            ),
            validator: (v) {
              if (v!.trim().isEmpty) {
                return 'Please enter something';
              }
              return null;
            },
          ),
          Gap(AppSizes.spaceBtwInputFields),
          RichText(
            text: TextSpan(
              text: "Disclaimer:",
              style: Theme.of(context).textTheme.titleLarge,
              children: [
                TextSpan(
                  text:
                      " Kirei does not influence, modify, or endorse any particular treatment, medicine, or skincare product prescribed or recommended by the doctor. The choice of treatment or product is entirely based on the doctor–patient discussion and individual medical judgment.",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.darkGrey,
                  ),
                ),
              ],
            ),
          ),
          const Gap(AppSizes.spaceBtwDefaultItems),

          Text(
            'Appointment Fee: ${AppLocalStorage().readData(LocalStorageKeys.doctorAppointmentFee)} BDT',
            style: Theme.of(context).textTheme.titleLarge?.apply(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
