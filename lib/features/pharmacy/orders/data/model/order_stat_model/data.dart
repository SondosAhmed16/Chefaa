import 'dart:convert';

import 'package:collection/collection.dart';

class Data {
  String? orderId;
  String? newStatus;

  Data({this.orderId, this.newStatus});

  @override
  String toString() => 'Data(orderId: $orderId, newStatus: $newStatus)';

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    orderId: data['orderId'] as String?,
    newStatus: data['newStatus'] as String?,
  );

  Map<String, dynamic> toMap() => {'orderId': orderId, 'newStatus': newStatus};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({String? orderId, String? newStatus}) {
    return Data(
      orderId: orderId ?? this.orderId,
      newStatus: newStatus ?? this.newStatus,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => orderId.hashCode ^ newStatus.hashCode;
}
