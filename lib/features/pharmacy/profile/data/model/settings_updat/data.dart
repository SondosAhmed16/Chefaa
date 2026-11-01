import 'dart:convert';

import 'package:collection/collection.dart';

class Data {
  bool? openNow;
  bool? deliveryAvailable;

  Data({this.openNow, this.deliveryAvailable});

  @override
  String toString() {
    return 'Data(openNow: $openNow, deliveryAvailable: $deliveryAvailable)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    openNow: data['openNow'] as bool?,
    deliveryAvailable: data['deliveryAvailable'] as bool?,
  );

  Map<String, dynamic> toMap() => {
    'openNow': openNow,
    'deliveryAvailable': deliveryAvailable,
  };

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

  Data copyWith({bool? openNow, bool? deliveryAvailable}) {
    return Data(
      openNow: openNow ?? this.openNow,
      deliveryAvailable: deliveryAvailable ?? this.deliveryAvailable,
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
  int get hashCode => openNow.hashCode ^ deliveryAvailable.hashCode;
}
