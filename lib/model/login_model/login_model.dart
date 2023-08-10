// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int? status;
  User? user;
  String? accessToken;
  String? tokenType;

  LoginModel({
    this.status,
    this.user,
    this.accessToken,
    this.tokenType,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    user: User.fromJson(json["user"]),
    accessToken: json["access_token"],
    tokenType: json["token_type"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "user": user?.toJson(),
    "access_token": accessToken,
    "token_type": tokenType,
  };
}

class User {
  int? id;
  int? roleId;
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
  String? webDeviceToken;
  String? deviceType;
  String? deviceId;
  String? age;
  String? kaleyraUserId;
  String? uvUserId;
  String? chatId;
  String? loginUsername;
  String? pincode;
  int? isDoctorAdmin;
  String? underAdminDoctor;
  String? successUserId;
  String? cetUserId;
  String? cetCompleted;
  int? isActive;
  String? addedBy;
  String? latitude;
  String? longitude;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? signupDate;

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
    this.webDeviceToken,
    this.deviceType,
    this.deviceId,
    this.age,
    this.kaleyraUserId,
    this.uvUserId,
    this.chatId,
    this.loginUsername,
    this.pincode,
    this.isDoctorAdmin,
    this.underAdminDoctor,
    this.successUserId,
    this.cetUserId,
    this.cetCompleted,
    this.isActive,
    this.addedBy,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.signupDate,
  });

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
    webDeviceToken: json["web_device_token"],
    deviceType: json["device_type"],
    deviceId: json["device_id"],
    age: json["age"],
    kaleyraUserId: json["kaleyra_user_id"],
    uvUserId: json['uv_user_id'],
    chatId: json["chat_id"],
    loginUsername: json["login_username"],
    pincode: json["pincode"],
    isDoctorAdmin: json["is_doctor_admin"],
    underAdminDoctor: json["under_admin_doctor"],
    successUserId: json["success_user_id"],
    cetUserId: json["cet_user_id"],
    cetCompleted: json["cet_completed"],
    isActive: json["is_active"],
    addedBy: json["added_by"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "web_device_token": webDeviceToken,
    "device_type": deviceType,
    "device_id": deviceId,
    "age": age,
    "kaleyra_user_id": kaleyraUserId,
    'uv_user_id': uvUserId,
    "chat_id": chatId,
    "login_username": loginUsername,
    "pincode": pincode,
    "is_doctor_admin": isDoctorAdmin,
    "under_admin_doctor": underAdminDoctor,
    "success_user_id": successUserId,
    "cet_user_id": cetUserId,
    "cet_completed": cetCompleted,
    "is_active": isActive,
    "added_by": addedBy,
    "latitude": latitude,
    "longitude": longitude,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "signup_date": signupDate,
  };
}

LoginModel loginFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginToJson(LoginModel data) => json.encode(data.toJson());
