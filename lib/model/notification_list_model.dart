// To parse this JSON data, do
//
//     final notificationList = notificationListFromJson(jsonString);

import 'dart:convert';

NotificationList notificationListFromJson(String str) => NotificationList.fromJson(json.decode(str));

String notificationListToJson(NotificationList data) => json.encode(data.toJson());

class NotificationList {
  NotificationList({
    required this.status,
    required this.errorCode,
    required this.key,
    required this.data,
  });

  int status;
  int errorCode;
  String key;
  List<NotificationModel> data;

  factory NotificationList.fromJson(Map<String, dynamic> json) => NotificationList(
    status: json["status"],
    errorCode: json["errorCode"],
    key: json["key"],
    data: List<NotificationModel>.from(json["data"].map((x) => NotificationModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "key": key,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class NotificationModel {
  NotificationModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.subject,
    required this.message,
    required this.requestId,
    required this.notificationType,
    required this.isRead,
    required this.addedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String userId;
  String type;
  String subject;
  String message;
  String requestId;
  String notificationType;
  String isRead;
  String addedBy;
  String createdAt;
  String updatedAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["id"],
    userId: json["user_id"].toString(),
    type: json["type"].toString(),
    subject: json["subject"].toString(),
    message: json["message"].toString(),
    requestId: json["request_id"].toString(),
    notificationType: json["notification_type"].toString(),
    isRead: json["is_read"].toString(),
    addedBy: json["added_by"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "type": type,
    "subject": subject,
    "message": message,
    "request_id": requestId,
    "notification_type": notificationType,
    "is_read": isRead,
    "added_by": addedBy,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
