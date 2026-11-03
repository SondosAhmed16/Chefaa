import 'dart:convert';

import 'package:collection/collection.dart';

class UpdatedRequest {
  String? id;
  String? labId;
  String? patientId;
  List<String>? services;
  bool? viaAi;
  String? status;
  List<String>? resultFile;
  String? resultFileType;
  DateTime? resultUploadedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  UpdatedRequest({
    this.id,
    this.labId,
    this.patientId,
    this.services,
    this.viaAi,
    this.status,
    this.resultFile,
    this.resultFileType,
    this.resultUploadedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'UpdatedRequest(id: $id, labId: $labId, patientId: $patientId, services: $services, viaAi: $viaAi, status: $status, resultFile: $resultFile, resultFileType: $resultFileType, resultUploadedAt: $resultUploadedAt, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  factory UpdatedRequest.fromMap(Map<String, dynamic> data) {
    return UpdatedRequest(
      id: data['_id'] as String?,
      labId: data['labId'] as String?,
      patientId: data['patientId'] as String?,
      services: (data['services'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      viaAi: data['viaAI'] as bool?,
      status: data['status'] as String?,
      resultFile: (data['resultFile'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      resultFileType: data['resultFileType'] as String?,
      resultUploadedAt: data['resultUploadedAt'] == null
          ? null
          : DateTime.parse(data['resultUploadedAt'] as String),
      createdAt: data['createdAt'] == null
          ? null
          : DateTime.parse(data['createdAt'] as String),
      updatedAt: data['updatedAt'] == null
          ? null
          : DateTime.parse(data['updatedAt'] as String),
      v: data['__v'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
    '_id': id,
    'labId': labId,
    'patientId': patientId,
    'services': services,
    'viaAI': viaAi,
    'status': status,
    'resultFile': resultFile,
    'resultFileType': resultFileType,
    'resultUploadedAt': resultUploadedAt?.toIso8601String(),
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UpdatedRequest].
  factory UpdatedRequest.fromJson(String data) {
    return UpdatedRequest.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UpdatedRequest] to a JSON string.
  String toJson() => json.encode(toMap());

  UpdatedRequest copyWith({
    String? id,
    String? labId,
    String? patientId,
    List<String>? services,
    bool? viaAi,
    String? status,
    List<String>? resultFile,
    String? resultFileType,
    DateTime? resultUploadedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return UpdatedRequest(
      id: id ?? this.id,
      labId: labId ?? this.labId,
      patientId: patientId ?? this.patientId,
      services: services ?? this.services,
      viaAi: viaAi ?? this.viaAi,
      status: status ?? this.status,
      resultFile: resultFile ?? this.resultFile,
      resultFileType: resultFileType ?? this.resultFileType,
      resultUploadedAt: resultUploadedAt ?? this.resultUploadedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UpdatedRequest) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      labId.hashCode ^
      patientId.hashCode ^
      services.hashCode ^
      viaAi.hashCode ^
      status.hashCode ^
      resultFile.hashCode ^
      resultFileType.hashCode ^
      resultUploadedAt.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      v.hashCode;
}
