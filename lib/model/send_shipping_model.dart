// To parse this JSON data, do
//
//     final sendShippingStatusModel = sendShippingStatusModelFromJson(jsonString);

import 'dart:convert';

SendShippingStatusModel sendShippingStatusModelFromJson(String str) => SendShippingStatusModel.fromJson(json.decode(str));

String sendShippingStatusModelToJson(SendShippingStatusModel data) => json.encode(data.toJson());

class SendShippingStatusModel {
  int status;
  int errorCode;
  String errorMsg;

  SendShippingStatusModel({
    required this.status,
    required this.errorCode,
    required this.errorMsg,
  });

  factory SendShippingStatusModel.fromJson(Map<String, dynamic> json) => SendShippingStatusModel(
    status: json["status"],
    errorCode: json["errorCode"],
    errorMsg: json["errorMsg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "errorMsg": errorMsg,
  };
}
