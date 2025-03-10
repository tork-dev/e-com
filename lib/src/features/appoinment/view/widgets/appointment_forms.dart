import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/appoinment/controller/appointment_controller.dart';
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
            visible: !AppLocalStorage()
                .readData(LocalStorageKeys.activeDoctorAppointment),
            child: AppCardContainer(
                backgroundColor: AppColors.primary.withOpacity(.7),
                applyRadius: false,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.md, vertical: AppSizes.md),
                child: Center(
                    child: Text(
                  'Doctor appointment is currently unavailable!',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .apply(color: AppColors.white),
                ))),
          ),
          AppAppointmentFormWidget(
            controller: appointmentController.fullNameController,
            labelText: 'Full Name*',
            inputType: TextInputType.text,
          ),
          AppAppointmentFormWidget(
            controller: appointmentController.ageController,
            labelText: 'Age*',
            inputType: TextInputType.number,
          ),
          AppAppointmentFormWidget(
              controller: appointmentController.contactNumberController,
              labelText: 'Contact Number*',
              inputType: TextInputType.number),
          AppAppointmentFormWidget(
              controller: appointmentController.whatsAppNumberController,
              labelText: 'WhatsApp Number*',
              inputType: TextInputType.number),
          TextFormField(
            keyboardType: TextInputType.multiline,
            minLines: 4,
            maxLines: 8,
            cursorColor: AppColors.primary,
            controller: appointmentController.problemController,
            decoration: InputDecoration(
                enabled: AppLocalStorage()
                    .readData(LocalStorageKeys.activeDoctorAppointment),
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
          Text(
            'Appointment Fee: ${AppLocalStorage().readData(LocalStorageKeys.doctorAppointmentFee)} BDT',
            style: const TextStyle(color: AppColors.warning),
          ),
        ],
      ),
    );
  }
}
