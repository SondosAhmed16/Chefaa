import 'dart:convert';

import 'package:collection/collection.dart';

import 'updated_request.dart';

class UploadResultModel {
  bool? success;
  String? message;
  UpdatedRequest? updatedRequest;

  UploadResultModel({this.success, this.message, this.updatedRequest});

  @override
  String toString() {
    return 'UploadResultModel(success: $success, message: $message, updatedRequest: $updatedRequest)';
  }

  factory UploadResultModel.fromMap(Map<String, dynamic>? data) {
    if (data == null) return UploadResultModel();
    return UploadResultModel(
      success: data['success'] as bool?,
      message: data['message'] as String?,
      updatedRequest: data['updatedRequest'] == null
          ? null
          : UpdatedRequest.fromMap(
              data['updatedRequest'] as Map<String, dynamic>,
            ),
    );
  }

  Map<String, dynamic> toMap() => {
    'success': success,
    'message': message,
    'updatedRequest': updatedRequest?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UploadResultModel].
  factory UploadResultModel.fromJson(String data) {
    return UploadResultModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UploadResultModel] to a JSON string.
  String toJson() => json.encode(toMap());

  UploadResultModel copyWith({
    bool? success,
    String? message,
    UpdatedRequest? updatedRequest,
  }) {
    return UploadResultModel(
      success: success ?? this.success,
      message: message ?? this.message,
      updatedRequest: updatedRequest ?? this.updatedRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UploadResultModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      success.hashCode ^ message.hashCode ^ updatedRequest.hashCode;
}
