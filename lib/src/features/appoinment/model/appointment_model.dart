class AppointmentResponse {
  bool? result;
  Data? data;
  String? message;

  AppointmentResponse({
    this.result,
    this.data,
    this.message,
  });

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentResponse(
      result: json['result'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'data': data?.toJson(),
      'message': message,
    };
  }
}

class Data {
  Appointment? appointment;
  String? paymentUrl;

  Data({
    this.appointment,
    this.paymentUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      appointment: json['appintment'] != null ? Appointment.fromJson(json['appintment']) : null,
      paymentUrl: json['payment_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appintment': appointment?.toJson(),
      'payment_url': paymentUrl,
    };
  }
}

class Appointment {
  String? name;
  String? age;
  String? contactNumber;
  String? whatsappNumber;
  String? problem;
  String? paymentType;
  int? paymentAmount;
  String? status;
  String? paymentStatus;
  dynamic availableDateId; // Change from int? to dynamic
  dynamic doctorId; // Change from int? to dynamic
  String? updatedAt;
  String? createdAt;
  int? id;

  Appointment({
    this.name,
    this.age,
    this.contactNumber,
    this.whatsappNumber,
    this.problem,
    this.paymentType,
    this.paymentAmount,
    this.status,
    this.paymentStatus,
    this.availableDateId,
    this.doctorId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      name: json['name'],
      age: json['age'],
      contactNumber: json['contact_number'],
      whatsappNumber: json['whatsapp_number'],
      problem: json['problem'],
      paymentType: json['payment_type'],
      paymentAmount: json['payment_amount'],
      status: json['status'],
      paymentStatus: json['payment_status'],
      availableDateId: json['available_date_id'],
      doctorId: json['doctor_id'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'contact_number': contactNumber,
      'whatsapp_number': whatsappNumber,
      'problem': problem,
      'payment_type': paymentType,
      'payment_amount': paymentAmount,
      'status': status,
      'payment_status': paymentStatus,
      'available_date_id': availableDateId,
      'doctor_id': doctorId,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
    };
  }
}
