class AdherenceHistory {
  AdherenceHistory({this.date, this.status, this.id});

  AdherenceHistory.fromJson(dynamic json) {
    date = json['date'];
    status = json['status'];
    id = json['_id'];
  }

  String? date;
  String? status;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['status'] = status;
    map['_id'] = id;
    return map;
  }
}
