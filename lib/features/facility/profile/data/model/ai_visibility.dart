import 'dart:convert';

import 'package:collection/collection.dart';

class AiVisibility {
  String? status;
  String? text;
  String? referrals;

  AiVisibility({this.status, this.text, this.referrals});

  @override
  String toString() {
    return 'AiVisibility(status: $status, text: $text, referrals: $referrals)';
  }

  factory AiVisibility.fromMap(Map<String, dynamic> data) => AiVisibility(
    status: data['status'] as String?,
    text: data['text'] as String?,
    referrals: data['referrals'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'status': status,
    'text': text,
    'referrals': referrals,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AiVisibility].
  factory AiVisibility.fromJson(String data) {
    return AiVisibility.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AiVisibility] to a JSON string.
  String toJson() => json.encode(toMap());

  AiVisibility copyWith({String? status, String? text, String? referrals}) {
    return AiVisibility(
      status: status ?? this.status,
      text: text ?? this.text,
      referrals: referrals ?? this.referrals,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AiVisibility) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => status.hashCode ^ text.hashCode ^ referrals.hashCode;
}
