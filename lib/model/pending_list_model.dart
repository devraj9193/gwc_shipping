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
    this.pending,
    this.paused,
    this.packed,
    //this.approved,
  });

  List<Pending>? pending;
  List<Pending>? paused;
  List<Approved>? packed;
 // List<Approved>? approved;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pending: List<Pending>.from(
            json["pending"].map((x) => Pending.fromJson(x))),
        paused:
            List<Pending>.from(json["paused"].map((x) => Pending.fromJson(x))),
        packed:
            List<Approved>.from(json["packed"].map((x) => Approved.fromJson(x))),
        // approved: List<Approved>.from(
        //     json["approved"].map((x) => Approved.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pending": List<dynamic>.from(pending!.map((x) => x.toJson())),
        "paused": List<dynamic>.from(paused!.map((x) => x.toJson())),
        "packed": List<dynamic>.from(packed!.map((x) => x.toJson())),
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
        teamId: json["team_id"],
        patientId: json["patient_id"],
        programId: json["program_id"],
        assignedDate: json["assigned_date"],
        uploadTime: json["upload_time"],
        status: json["status"],
        isArchieved: json["is_archieved"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        appointmentDate: json["appointment_date"],
        appointmentTime: json["appointment_time"],
        updateDate: json["update_date"],
        updateTime: json["update_time"],
        manifestUrl: json["manifest_url"],
        labelUrl: json["label_url"],
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
        teamPatientId: json["team_patient_id"],
        date: json["date"],
        slotStartTime: json["slot_start_time"],
        slotEndTime: json["slot_end_time"],
        type: json["type"],
        status: json["status"],
        zoomJoinUrl: json["zoom_join_url"],
        zoomStartUrl: json["zoom_start_url"],
        zoomId: json["zoom_id"],
        zoomPassword: json["zoom_password"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        appointmentDate: json["appointment_date"],
        appointmentStartTime: json["appointment_start_time"],
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
        teamPatientId: json["team_patient_id"],
        orderId: json["order_id"],
        shippingId: json["shipping_id"],
        awbCode: json["awb_code"],
        courierName: json["courier_name"],
        courierCompanyId: json["courier_company_id"],
        assignedDateTime: json["assigned_date_time"],
        labelUrl: json["label_url"],
        manifestUrl: json["manifest_url"],
        pickupTokenNumber: json["pickup_token_number"],
        routingCode: json["routing_code"],
        pickupScheduledDate: json["pickup_scheduled_date"],
        status: json["status"],
        addedBy: json["added_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
  String? isArchieved;
  String? createdAt;
  String? updatedAt;
  User? user;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json["id"],
        userId: json["user_id"],
        maritalStatus: json["marital_status"],
        address2: json["address2"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        weight: json["weight"],
        status: json["status"],
        isArchieved: json["is_archieved"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
        roleId: json["role_id"],
        name: json["name"],
        fname: json["fname"],
        lname: json["lname"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        countryCode: json["country_code"],
        phone: json["phone"],
        gender: json["gender"],
        profile: json["profile"],
        address: json["address"],
        otp: json["otp"],
        deviceToken: json["device_token"],
        deviceType: json["device_type"],
        deviceId: json["device_id"],
        age: json["age"],
        pincode: json["pincode"],
        isActive: json["is_active"],
        addedBy: json["added_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        signupDate: json["signup_date"],
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
        teamId: json["team_id"],
        patientId: json["patient_id"],
        programId: json["program_id"],
        assignedDate: json["assigned_date"],
        uploadTime: json["upload_time"],
        status: json["status"],
        isArchieved: json["is_archieved"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        appointmentDate: json["appointment_date"],
        appointmentTime: json["appointment_time"],
        updateDate: json["update_date"],
        updateTime: json["update_time"],
        manifestUrl: json["manifest_url"],
        labelUrl: json["label_url"],
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
