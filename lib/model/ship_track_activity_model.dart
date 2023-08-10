class ShipmentTrackActivities {
  String? date;
  String? status;
  String? activity;
  String? location;
  String? srStatus;
  String? srStatusLabel;

  ShipmentTrackActivities(
      {this.date,
      this.status,
      this.activity,
      this.location,
      this.srStatus,
      this.srStatusLabel});

  ShipmentTrackActivities.fromJson(Map<String, dynamic> json) {
    date = json['date'].toString();
    status = json['status'].toString();
    activity = json['activity'].toString();
    location = json['location'].toString();
    srStatus = json['sr-status'].toString();
    srStatusLabel = json['sr-status-label'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['status'] = status;
    data['activity'] = activity;
    data['location'] = location;
    data['sr-status'] = srStatus;
    data['sr-status-label'] = srStatusLabel;
    return data;
  }
}
