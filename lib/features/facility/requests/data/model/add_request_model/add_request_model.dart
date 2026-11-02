import 'dart:convert';

import 'package:collection/collection.dart';

import 'new_request.dart';

class AddRequestModel {
  bool? success;
  String? message;
  NewRequest? newRequest;

  AddRequestModel({this.success, this.message, this.newRequest});

  @override
  String toString() {
    return 'AddRequestModel(success: $success, message: $message, newRequest: $newRequest)';
  }

  factory AddRequestModel.fromMap(Map<String, dynamic> data) {
    return AddRequestModel(
      success: data['success'] as bool?,
      message: data['message'] as String?,
      newRequest: data['newRequest'] == null
          ? null
          : NewRequest.fromMap(data['newRequest'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
    'success': success,
    'message': message,
    'newRequest': newRequest?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AddRequestModel].
  factory AddRequestModel.fromJson(String data) {
    return AddRequestModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AddRequestModel] to a JSON string.
  String toJson() => json.encode(toMap());

  AddRequestModel copyWith({
    bool? success,
    String? message,
    NewRequest? newRequest,
  }) {
    return AddRequestModel(
      success: success ?? this.success,
      message: message ?? this.message,
      newRequest: newRequest ?? this.newRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AddRequestModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ newRequest.hashCode;
}
