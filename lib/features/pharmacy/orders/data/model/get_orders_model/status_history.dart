import 'dart:convert';

class StatusHistory {
  String? status;
  DateTime? timestamp;

  StatusHistory({this.status, this.timestamp});

  factory StatusHistory.fromMap(Map<String, dynamic> map) {
    return StatusHistory(
      status: map['status'] as String?,
      timestamp: map['timestamp'] == null
          ? null
          : DateTime.parse(map['timestamp'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {'status': status, 'timestamp': timestamp?.toIso8601String()};
  }

  factory StatusHistory.fromJson(String source) =>
      StatusHistory.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());
}
