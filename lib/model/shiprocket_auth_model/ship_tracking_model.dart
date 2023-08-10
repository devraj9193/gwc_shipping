// To parse this JSON data, do
//
//     final shipTrackingModel = shipTrackingModelFromJson(jsonString);

import 'dart:convert';

ShipTrackingModel shipTrackingModelFromJson(String str) =>
    ShipTrackingModel.fromJson(json.decode(str));

String shipTrackingModelToJson(ShipTrackingModel data) =>
    json.encode(data.toJson());

class ShipTrackingModel {
  ShipTrackingModel({
    this.trackingData,
  });

  TrackingData? trackingData;

  factory ShipTrackingModel.fromJson(Map<String, dynamic> json) =>
      ShipTrackingModel(
        trackingData: TrackingData.fromJson(json["tracking_data"]),
      );

  Map<String, dynamic> toJson() => {
        "tracking_data": trackingData?.toJson(),
      };
}

class TrackingData {
  int? trackStatus;
  int? shipmentStatus;
  List<ShipmentTrack>? shipmentTrack;
  List<ShipmentTrackActivity>? shipmentTrackActivities;
  String? trackUrl;
  String? etd;
  QcResponse? qcResponse;
  String? error;

  TrackingData(
      {this.trackStatus,
        this.shipmentStatus,
        this.shipmentTrack,
        this.shipmentTrackActivities,
        this.trackUrl,
        this.etd,
        this.qcResponse,
        this.error
      });

  TrackingData.fromJson(Map<String, dynamic> json) {
    trackStatus = json['track_status'];
    shipmentStatus = json['shipment_status'];
    if (json['shipment_track'] != null) {
      shipmentTrack = <ShipmentTrack>[];
      json['shipment_track'].forEach((v) {
        shipmentTrack!.add( ShipmentTrack.fromJson(v));
      });
    }
    if (json['shipment_track_activities'] != null) {
      shipmentTrackActivities = <ShipmentTrackActivity>[];
      json['shipment_track_activities'].forEach((v) {
        shipmentTrackActivities!.add(ShipmentTrackActivity.fromJson(v));
      });
    }
    trackUrl = json['track_url'];
    etd = json['etd'];
    qcResponse = json['qc_response'] != null
        ? QcResponse.fromJson(json['qc_response'])
        : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['track_status'] = trackStatus;
    data['shipment_status'] = shipmentStatus;
    if (shipmentTrack != null) {
      data['shipment_track'] =
          shipmentTrack!.map((v) => v.toJson()).toList();
    }
    if (shipmentTrackActivities != null) {
      data['shipment_track_activities'] =
          shipmentTrackActivities!.map((v) => v.toJson()).toList();
    }
    data['track_url'] = trackUrl;
    data['etd'] = etd;
    if (qcResponse != null) {
      data['qc_response'] = qcResponse!.toJson();
    }
    data['error'] = error;
    return data;
  }
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
    this.courierName,
    this.edd,
  });

  int? id;
  String? awbCode;
  String? courierCompanyId;
  String? shipmentId;
  String? orderId;
  String? pickupDate;
  String? deliveredDate;
  String? weight;
  String? packages;
  String? currentStatus;
  String? deliveredTo;
  String? destination;
  String? consigneeName;
  String? origin;
  String? courierAgentDetails;
  String? courierName;
  String? edd;

  factory ShipmentTrack.fromJson(Map<String, dynamic> json) => ShipmentTrack(
        id: json["id"],
        awbCode: json["awb_code"].toString(),
        courierCompanyId: json["courier_company_id"].toString(),
        shipmentId: json["shipment_id"].toString(),
        orderId: json["order_id"].toString(),
        pickupDate: json["pickup_date"].toString(),
        deliveredDate: json["delivered_date"].toString(),
        weight: json["weight"].toString(),
        packages: json["packages"].toString(),
        currentStatus: json["current_status"].toString(),
        deliveredTo: json["delivered_to"].toString(),
        destination: json["destination"].toString(),
        consigneeName: json["consignee_name"].toString(),
        origin: json["origin"].toString(),
        courierAgentDetails: json["courier_agent_details"].toString(),
        courierName: json["courier_name"].toString(),
        edd: json["edd"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "awb_code": awbCode.toString(),
        "courier_company_id": courierCompanyId.toString(),
        "shipment_id": shipmentId.toString(),
        "order_id": orderId.toString(),
        "pickup_date": pickupDate.toString(),
        "delivered_date": deliveredDate.toString(),
        "weight": weight.toString(),
        "packages": packages.toString(),
        "current_status": currentStatus.toString(),
        "delivered_to": deliveredTo.toString(),
        "destination": destination.toString(),
        "consignee_name": consigneeName.toString(),
        "origin": origin.toString(),
        "courier_agent_details": courierAgentDetails.toString(),
        "courier_name": courierName.toString(),
        "edd": edd.toString(),
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

  factory ShipmentTrackActivity.fromJson(Map<String, dynamic> json) =>
      ShipmentTrackActivity(
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
