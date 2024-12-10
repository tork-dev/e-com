import 'package:flutter/material.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

class AppAppointmentFormWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType inputType;
  const AppAppointmentFormWidget({super.key, required this.labelText, required this.controller, required this.inputType });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.primary,
      keyboardType: inputType,
      decoration:  InputDecoration(
        enabled: AppLocalStorage().readData(LocalStorageKeys.activeDoctorAppointment),
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodySmall,
        floatingLabelStyle: const TextStyle(color: AppColors.primary),
        focusedBorder: const UnderlineInputBorder(
            borderSide:
            BorderSide(color: AppColors.primary, width: 2)),
        ),
      validator: (v) {
        if (v!.trim().isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
    },
    );
  }
}

