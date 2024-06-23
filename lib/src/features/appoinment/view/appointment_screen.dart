import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:torganic/src/features/appoinment/controller/appointment_controller.dart';
import 'package:torganic/src/features/appoinment/view/widgets/appointment_form_widget.dart';
import 'package:torganic/src/features/appoinment/view/widgets/appointment_forms.dart';
import 'package:torganic/src/utils/constants/colors.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentController = Get.put(AppointmentController());
    return AppLayoutWithDrawer(
        backgroundColor: AppColors.white,
        globalKey: appointmentController.appointmentKey,
        title: const Text(
          'Appointment',
          style: TextStyle(color: Colors.blueGrey),
        ),
        centerTitle: true,
        leadingIconColor: AppColors.darkGrey,
        bodyBackgroundColor: Colors.grey[100],
        body: const AppAppointmentForms());
  }
}
