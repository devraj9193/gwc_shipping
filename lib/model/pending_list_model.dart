// To parse this JSON data, do
//
//     final pendingUserList = pendingUserListFromJson(jsonString);

import 'dart:convert';

PendingUserList pendingUserListFromJson(String str) =>
    PendingUserList.fromJson(json.decode(str));

String pendingUserListToJson(PendingUserList data) =>
    json.encode(data.toJson());

class PendingUserList {
  PendingUserList({
    this.status,
    this.errorCode,
    this.data,
  });

  int? status;
  int? errorCode;
  Data? data;

  factory PendingUserList.fromJson(Map<String, dynamic> json) =>
      PendingUserList(
        status: json["status"],
        errorCode: json["errorCode"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    required this.pending,
    required this.paused,
    required this.packed,
    required this.delivered,
    //this.approved,
  });

  List<Pending> pending;
  List<Pending> paused;
  List<Approved> packed;
  List<Approved> delivered;
  // List<Approved>? approved;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pending:
    List<Pending>.from(json["pending"].map((x) => Pending.fromJson(x))),
    paused:
    List<Pending>.from(json["paused"].map((x) => Pending.fromJson(x))),
    packed: List<Approved>.from(
        json["packed"].map((x) => Approved.fromJson(x))),
    delivered: List<Approved>.from(
        json["delivered"].map((x) => Approved.fromJson(x))),
    // approved: List<Approved>.from(
    //     json["approved"].map((x) => Approved.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pending": List<dynamic>.from(pending.map((x) => x.toJson())),
    "paused": List<dynamic>.from(paused.map((x) => x.toJson())),
    "packed": List<dynamic>.from(packed.map((x) => x.toJson())),
    "delivered": List<dynamic>.from(delivered.map((x) => x.toJson())),
    //"approved": List<dynamic>.from(approved!.map((x) => x.toJson())),
  };
}

class Approved {
  Approved({
    this.id,
    this.teamId,
    this.patientId,
    this.programId,
    this.assignedDate,
    this.uploadTime,
    this.status,
    this.isArchieved,
    this.createdAt,
    this.updatedAt,
    this.appointmentDate,
    this.appointmentTime,
    this.updateDate,
    this.updateTime,
    this.manifestUrl,
    this.labelUrl,
    this.patient,
    this.appointments,
    this.orders,
  });

  int? id;
  String? teamId;
  String? patientId;
  String? programId;
  String? assignedDate;
  String? uploadTime;
  String? status;
  String? isArchieved;
  String? createdAt;
  String? updatedAt;
  String? appointmentDate;
  String? appointmentTime;
  String? updateDate;
  String? updateTime;
  String? manifestUrl;
  String? labelUrl;
  Patient? patient;
  List<Appointment>? appointments;
  List<Order>? orders;

  factory Approved.fromJson(Map<String, dynamic> json) => Approved(
    id: json["id"],
    teamId: json["team_id"].toString(),
    patientId: json["patient_id"].toString(),
    programId: json["program_id"].toString(),
    assignedDate: json["assigned_date"].toString(),
    uploadTime: json["upload_time"].toString(),
    status: json["status"].toString(),
    isArchieved: json["is_archieved"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
    appointmentDate: json["appointment_date"].toString(),
    appointmentTime: json["appointment_time"].toString(),
    updateDate: json["update_date"].toString(),
    updateTime: json["update_time"].toString(),
    manifestUrl: json["manifest_url"].toString(),
    labelUrl: json["label_url"].toString(),
    patient: Patient.fromJson(json["patient"]),
    appointments: List<Appointment>.from(
        json["appointments"].map((x) => Appointment.fromJson(x))),
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "team_id": teamId,
    "patient_id": patientId,
    "program_id": programId,
    "assigned_date": assignedDate,
    "upload_time": uploadTime,
    "status": status,
    "is_archieved": isArchieved,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "appointment_date": appointmentDate,
    "appointment_time": appointmentTime,
    "update_date": updateDate,
    "update_time": updateTime,
    "manifest_url": manifestUrl,
    "label_url": labelUrl,
    "patient": patient?.toJson(),
    "appointments":
    List<dynamic>.from(appointments!.map((x) => x.toJson())),
    "orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
  };
}

class Appointment {
  Appointment({
    this.id,
    this.teamPatientId,
    this.date,
    this.slotStartTime,
    this.slotEndTime,
    this.type,
    this.status,
    this.zoomJoinUrl,
    this.zoomStartUrl,
    this.zoomId,
    this.zoomPassword,
    this.createdAt,
    this.updatedAt,
    this.appointmentDate,
    this.appointmentStartTime,
  });

  int? id;
  String? teamPatientId;
  String? date;
  String? slotStartTime;
  String? slotEndTime;
  String? type;
  String? status;
  String? zoomJoinUrl;
  String? zoomStartUrl;
  String? zoomId;
  String? zoomPassword;
  String? createdAt;
  String? updatedAt;
  String? appointmentDate;
  String? appointmentStartTime;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    id: json["id"],
    teamPatientId: json["team_patient_id"].toString(),
    date: json["date"].toString(),
    slotStartTime: json["slot_start_time"].toString(),
    slotEndTime: json["slot_end_time"].toString(),
    type: json["type"].toString(),
    status: json["status"].toString(),
    zoomJoinUrl: json["zoom_join_url"].toString(),
    zoomStartUrl: json["zoom_start_url"].toString(),
    zoomId: json["zoom_id"].toString(),
    zoomPassword: json["zoom_password"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
    appointmentDate: json["appointment_date"].toString(),
    appointmentStartTime: json["appointment_start_time"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "team_patient_id": teamPatientId,
    "date": date,
    "slot_start_time": slotStartTime,
    "slot_end_time": slotEndTime,
    "type": type,
    "status": status,
    "zoom_join_url": zoomJoinUrl,
    "zoom_start_url": zoomStartUrl,
    "zoom_id": zoomId,
    "zoom_password": zoomPassword,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "appointment_date": appointmentDate,
    "appointment_start_time": appointmentStartTime,
  };
}

class Order {
  Order({
    this.id,
    this.teamPatientId,
    this.orderId,
    this.shippingId,
    this.awbCode,
    this.courierName,
    this.courierCompanyId,
    this.assignedDateTime,
    this.labelUrl,
    this.manifestUrl,
    this.pickupTokenNumber,
    this.routingCode,
    this.pickupScheduledDate,
    this.status,
    this.addedBy,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? teamPatientId;
  String? orderId;
  String? shippingId;
  String? awbCode;
  String? courierName;
  String? courierCompanyId;
  String? assignedDateTime;
  String? labelUrl;
  String? manifestUrl;
  String? pickupTokenNumber;
  String? routingCode;
  String? pickupScheduledDate;
  String? status;
  String? addedBy;
  String? createdAt;
  String? updatedAt;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    teamPatientId: json["team_patient_id"].toString(),
    orderId: json["order_id"].toString(),
    shippingId: json["shipping_id"].toString(),
    awbCode: json["awb_code"].toString(),
    courierName: json["courier_name"].toString(),
    courierCompanyId: json["courier_company_id"].toString(),
    assignedDateTime: json["assigned_date_time"].toString(),
    labelUrl: json["label_url"].toString(),
    manifestUrl: json["manifest_url"].toString(),
    pickupTokenNumber: json["pickup_token_number"].toString(),
    routingCode: json["routing_code"].toString(),
    pickupScheduledDate: json["pickup_scheduled_date"].toString(),
    status: json["status"].toString(),
    addedBy: json["added_by"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "team_patient_id": teamPatientId,
    "order_id": orderId,
    "shipping_id": shippingId,
    "awb_code": awbCode,
    "courier_name": courierName,
    "courier_company_id": courierCompanyId,
    "assigned_date_time": assignedDateTime,
    "label_url": labelUrl,
    "manifest_url": manifestUrl,
    "pickup_token_number": pickupTokenNumber,
    "routing_code": routingCode,
    "pickup_scheduled_date": pickupScheduledDate,
    "status": status,
    "added_by": addedBy,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Patient {
  Patient({
    this.id,
    this.userId,
    this.maritalStatus,
    this.address2,
    this.city,
    this.state,
    this.country,
    this.weight,
    this.status,
    this.shippingDeliveryDate,
    this.isArchieved,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  String? userId;
  String? maritalStatus;
  String? address2;
  String? city;
  String? state;
  String? country;
  String? weight;
  String? status;
  String? shippingDeliveryDate;
  String? isArchieved;
  String? createdAt;
  String? updatedAt;
  User? user;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json["id"],
    userId: json["user_id"].toString(),
    maritalStatus: json["marital_status"].toString(),
    address2: json["address2"].toString(),
    city: json["city"].toString(),
    state: json["state"].toString(),
    country: json["country"].toString(),
    weight: json["weight"].toString(),
    status: json["status"].toString(),
    shippingDeliveryDate: json["shipping_delivery_date"].toString(),
    isArchieved: json["is_archieved"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "marital_status": maritalStatus,
    "address2": address2,
    "city": city,
    "state": state,
    "country": country,
    "weight": weight,
    "status": status,
    "shipping_delivery_date": shippingDeliveryDate,
    "is_archieved": isArchieved,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "user": user?.toJson(),
  };
}

class User {
  User({
    this.id,
    this.roleId,
    this.name,
    this.fname,
    this.lname,
    this.email,
    this.emailVerifiedAt,
    this.countryCode,
    this.kaleyraUserId,
    this.phone,
    this.gender,
    this.profile,
    this.address,
    this.otp,
    this.deviceToken,
    this.deviceType,
    this.deviceId,
    this.age,
    this.pincode,
    this.isActive,
    this.addedBy,
    this.createdAt,
    this.updatedAt,
    this.signupDate,
  });

  int? id;
  String? roleId;
  String? name;
  String? fname;
  String? lname;
  String? email;
  String? emailVerifiedAt;
  String? countryCode;
  String? kaleyraUserId;
  String? phone;
  String? gender;
  String? profile;
  String? address;
  String? otp;
  String? deviceToken;
  String? deviceType;
  String? deviceId;
  String? age;
  String? pincode;
  String? isActive;
  String? addedBy;
  String? createdAt;
  String? updatedAt;
  String? signupDate;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    roleId: json["role_id"].toString(),
    name: json["name"].toString(),
    fname: json["fname"].toString(),
    lname: json["lname"].toString(),
    email: json["email"].toString(),
    emailVerifiedAt: json["email_verified_at"].toString().toString(),
    countryCode: json["country_code"],
    phone: json["phone"].toString().toString(),
    gender: json["gender"].toString(),
    profile: json["profile"].toString(),
    address: json["address"].toString(),
    otp: json["otp"].toString(),
    deviceToken: json["device_token"].toString(),
    kaleyraUserId: json["kaleyra_user_id"].toString(),
    deviceType: json["device_type"].toString(),
    deviceId: json["device_id"].toString(),
    age: json["age"].toString(),
    pincode: json["pincode"].toString(),
    isActive: json["is_active"].toString(),
    addedBy: json["added_by"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
    signupDate: json["signup_date"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "role_id": roleId,
    "name": name,
    "fname": fname,
    "lname": lname,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "country_code": countryCode,
    "phone": phone,
    "gender": gender,
    "profile": profile,
    "address": address,
    "otp": otp,
    "device_token": deviceToken,
    "kaleyra_user_id": kaleyraUserId,
    "device_type": deviceType,
    "device_id": deviceId,
    "age": age,
    "pincode": pincode,
    "is_active": isActive,
    "added_by": addedBy,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "signup_date": signupDate,
  };
}

class Pending {
  Pending({
    this.id,
    this.teamId,
    this.patientId,
    this.programId,
    this.assignedDate,
    this.uploadTime,
    this.status,
    this.isArchieved,
    this.createdAt,
    this.updatedAt,
    this.appointmentDate,
    this.appointmentTime,
    this.updateDate,
    this.updateTime,
    this.manifestUrl,
    this.labelUrl,
    this.patient,
    this.appointments,
  });

  int? id;
  String? teamId;
  String? patientId;
  String? programId;
  String? assignedDate;
  String? uploadTime;
  String? status;
  String? isArchieved;
  String? createdAt;
  String? updatedAt;
  String? appointmentDate;
  String? appointmentTime;
  String? updateDate;
  String? updateTime;
  String? manifestUrl;
  String? labelUrl;
  Patient? patient;
  List<Appointment>? appointments;

  factory Pending.fromJson(Map<String, dynamic> json) => Pending(
    id: json["id"],
    teamId: json["team_id"].toString(),
    patientId: json["patient_id"].toString(),
    programId: json["program_id"].toString(),
    assignedDate: json["assigned_date"].toString(),
    uploadTime: json["upload_time"].toString(),
    status: json["status"].toString(),
    isArchieved: json["is_archieved"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
    appointmentDate: json["appointment_date"].toString(),
    appointmentTime: json["appointment_time"].toString(),
    updateDate: json["update_date"].toString(),
    updateTime: json["update_time"].toString(),
    manifestUrl: json["manifest_url"].toString().toString(),
    labelUrl: json["label_url"].toString(),
    patient: Patient.fromJson(json["patient"]),
    appointments: List<Appointment>.from(
        json["appointments"].map((x) => Appointment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "team_id": teamId,
    "patient_id": patientId,
    "program_id": programId,
    "assigned_date": assignedDate,
    "upload_time": uploadTime,
    "status": status,
    "is_archieved": isArchieved,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "appointment_date": appointmentDate,
    "appointment_time": appointmentTime,
    "update_date": updateDate,
    "update_time": updateTime,
    "manifest_url": manifestUrl,
    "label_url": labelUrl,
    "patient": patient?.toJson(),
    "appointments":
    List<dynamic>.from(appointments!.map((x) => x.toJson())),
  };
}
