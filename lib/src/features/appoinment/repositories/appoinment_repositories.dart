import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import '../model/appointment_model.dart';
class AppointmentRepository {
  Future<AppointmentResponse> submitAppointment({
    required String age,
    required String contactNumber,
    required String name,
    required String paymentType,
    required String problem,
    required String whatsappNumber,
  }) async {
    var postBody = jsonEncode({
      'age': age,
      'contact_number': contactNumber,
      'name': name,
      'payment_type': paymentType,
      'problem': problem,
      'whatsapp_number': whatsappNumber,
    });
    final response = await http.post(
        Uri.parse(AppApiEndPoints.appointmentStore),
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
        },
        body: postBody);

    return AppointmentResponse.fromJson(jsonDecode(response.body));
  }
}