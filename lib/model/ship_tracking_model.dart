// To parse this JSON data, do
//
//     final shipTrackingModel = shipTrackingModelFromJson(jsonString);

import 'dart:convert';

ShipTrackingModel shipTrackingModelFromJson(String str) => ShipTrackingModel.fromJson(json.decode(str));

String shipTrackingModelToJson(ShipTrackingModel data) => json.encode(data.toJson());

class ShipTrackingModel {
  ShipTrackingModel({
    this.trackingData,
  });

  TrackingData? trackingData;

  factory ShipTrackingModel.fromJson(Map<String, dynamic> json) => ShipTrackingModel(
    trackingData: TrackingData.fromJson(json["tracking_data"]),
  );

  Map<String, dynamic> toJson() => {
    "tracking_data": trackingData?.toJson(),
  };
}

class TrackingData {
  TrackingData({
    this.trackStatus,
    this.shipmentStatus,
    this.shipmentTrack,
    this.shipmentTrackActivities,
    this.trackUrl,
    this.etd,
    this.qcResponse,
  });

  int? trackStatus;
  int? shipmentStatus;
  List<ShipmentTrack>? shipmentTrack;
  List<ShipmentTrackActivity>? shipmentTrackActivities;
  String? trackUrl;
  DateTime? etd;
  QcResponse? qcResponse;

  factory TrackingData.fromJson(Map<String, dynamic> json) => TrackingData(
    trackStatus: json["track_status"],
    shipmentStatus: json["shipment_status"],
    shipmentTrack: List<ShipmentTrack>.from(json["shipment_track"].map((x) => ShipmentTrack.fromJson(x))),
    shipmentTrackActivities: List<ShipmentTrackActivity>.from(json["shipment_track_activities"].map((x) => ShipmentTrackActivity.fromJson(x))),
    trackUrl: json["track_url"],
    etd: DateTime.parse(json["etd"]),
    qcResponse: QcResponse.fromJson(json["qc_response"]),
  );

  Map<String, dynamic> toJson() => {
    "track_status": trackStatus,
    "shipment_status": shipmentStatus,
    "shipment_track": List<dynamic>.from(shipmentTrack!.map((x) => x.toJson())),
    "shipment_track_activities": List<dynamic>.from(shipmentTrackActivities!.map((x) => x.toJson())),
    "track_url": trackUrl,
    "etd": etd?.toIso8601String(),
    "qc_response": qcResponse?.toJson(),
  };
}

class QcResponse {
  QcResponse({
    this.qcImage,
    this.qcFailedReason,
  });

  String? qcImage;
  String? qcFailedReason;

  factory QcResponse.fromJson(Map<String, dynamic> json) => QcResponse(
    qcImage: json["qc_image"],
    qcFailedReason: json["qc_failed_reason"],
  );

  Map<String, dynamic> toJson() => {
    "qc_image": qcImage,
    "qc_failed_reason": qcFailedReason,
  };
}

class ShipmentTrack {
  ShipmentTrack({
    this.id,
    this.awbCode,
    this.courierCompanyId,
    this.shipmentId,
    this.orderId,
    this.pickupDate,
    this.deliveredDate,
    this.weight,
    this.packages,
    this.currentStatus,
    this.deliveredTo,
    this.destination,
    this.consigneeName,
    this.origin,
    this.courierAgentDetails,
    this.edd,
  });

  int? id;
  String? awbCode;
  int? courierCompanyId;
  int? shipmentId;
  int? orderId;
  DateTime? pickupDate;
  DateTime? deliveredDate;
  String? weight;
  int? packages;
  String? currentStatus;
  String? deliveredTo;
  String? destination;
  String? consigneeName;
  String? origin;
  String? courierAgentDetails;
  String? edd;

  factory ShipmentTrack.fromJson(Map<String, dynamic> json) => ShipmentTrack(
    id: json["id"],
    awbCode: json["awb_code"],
    courierCompanyId: json["courier_company_id"],
    shipmentId: json["shipment_id"],
    orderId: json["order_id"],
    pickupDate: DateTime.parse(json["pickup_date"]),
    deliveredDate: DateTime.parse(json["delivered_date"]),
    weight: json["weight"],
    packages: json["packages"],
    currentStatus: json["current_status"],
    deliveredTo: json["delivered_to"],
    destination: json["destination"],
    consigneeName: json["consignee_name"],
    origin: json["origin"],
    courierAgentDetails: json["courier_agent_details"],
    edd: json["edd"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "awb_code": awbCode,
    "courier_company_id": courierCompanyId,
    "shipment_id": shipmentId,
    "order_id": orderId,
    "pickup_date": pickupDate?.toIso8601String(),
    "delivered_date": deliveredDate?.toIso8601String(),
    "weight": weight,
    "packages": packages,
    "current_status": currentStatus,
    "delivered_to": deliveredTo,
    "destination": destination,
    "consignee_name": consigneeName,
    "origin": origin,
    "courier_agent_details": courierAgentDetails,
    "edd": edd,
  };
}

class ShipmentTrackActivity {
  ShipmentTrackActivity({
    this.date,
    this.status,
    this.activity,
    this.location,
    this.srStatus,
    this.srStatusLabel,
  });

  DateTime? date;
  String? status;
  String? activity;
  String? location;
  String? srStatus;
  String? srStatusLabel;

  factory ShipmentTrackActivity.fromJson(Map<String, dynamic> json) => ShipmentTrackActivity(
    date: DateTime.parse(json["date"]),
    status: json["status"],
    activity: json["activity"],
    location: json["location"],
    srStatus: json["sr-status"],
    srStatusLabel: json["sr-status-label"],
  );

  Map<String, dynamic> toJson() => {
    "date": date?.toIso8601String(),
    "status": status,
    "activity": activity,
    "location": location,
    "sr-status": srStatus,
    "sr-status-label": srStatusLabel,
  };
}
