import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/features/appoinment/controller/appointment_controller.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../../../utils/constants/colors.dart';
import 'appointment_form_widget.dart';

class AppAppointmentForms extends StatelessWidget {
  const AppAppointmentForms({super.key});

  @override
  Widget build(BuildContext context) {
    AppointmentController appointmentController = AppointmentController.instance;
    return Form(
      //key: appointmentController.appointmentFormKey,
      child: ListView(
        shrinkWrap: true,
        children: [
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
            decoration:  InputDecoration(
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
          const Gap(AppSizes.spaceBtwItems),
          const Text('Appointment Fee: 499 BDT', style: TextStyle(color: AppColors.warning),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: AppHelperFunctions.screenWidth() * .5,
                child: RadioListTile(
                    value: 1,
                    groupValue:1,
                    onChanged: (value){},
                    activeColor: AppColors.darkGrey,
                  title: Text('Bkash', style: TextStyle(color: AppColors.darkGrey),),

                ),
              ),
              Icon(Icons.payment)
            ],
          ),
          AppButtons.largeFlatFilledButton(
              onPressed: (){

              },
              backgroundColor: AppColors.darkGrey,
              buttonText: 'Make payment'.toUpperCase())

        ],
      ),
    );
  }
}

