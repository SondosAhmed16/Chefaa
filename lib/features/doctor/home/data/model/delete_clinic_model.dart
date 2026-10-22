import 'dart:convert';

import 'package:collection/collection.dart';

class DeleteClinicModel {
  String? message;

  DeleteClinicModel({this.message});

  @override
  String toString() => 'DeleteClinicModel(message: $message)';

  factory DeleteClinicModel.fromMap(Map<String, dynamic> data) {
    return DeleteClinicModel(message: data['message'] as String?);
  }

  Map<String, dynamic> toMap() => {'message': message};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DeleteClinicModel].
  factory DeleteClinicModel.fromJson(String data) {
    return DeleteClinicModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DeleteClinicModel] to a JSON string.
  String toJson() => json.encode(toMap());

  DeleteClinicModel copyWith({String? message}) {
    return DeleteClinicModel(message: message ?? this.message);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DeleteClinicModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => message.hashCode;
}
