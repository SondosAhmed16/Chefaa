import 'dart:convert';

import 'package:collection/collection.dart';

class NewRequest {
  String? labId;
  String? patientId;
  List<String>? services;
  bool? viaAi;
  String? status;
  List<dynamic>? resultFile;
  dynamic resultFileType;
  dynamic resultUploadedAt;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  NewRequest({
    this.labId,
    this.patientId,
    this.services,
    this.viaAi,
    this.status,
    this.resultFile,
    this.resultFileType,
    this.resultUploadedAt,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'NewRequest(labId: $labId, patientId: $patientId, services: $services, viaAi: $viaAi, status: $status, resultFile: $resultFile, resultFileType: $resultFileType, resultUploadedAt: $resultUploadedAt, id: $id, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  factory NewRequest.fromMap(Map<String, dynamic> data) => NewRequest(
    labId: data['labId'] as String?,
    patientId: data['patientId'] as String?,
    services: (data['services'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
    viaAi: data['viaAI'] as bool?,
    status: data['status'] as String?,
    resultFile: data['resultFile'] as List<dynamic>?,
    resultFileType: data['resultFileType'] as dynamic,
    resultUploadedAt: data['resultUploadedAt'] as dynamic,
    id: data['_id'] as String?,
    createdAt: data['createdAt'] == null
        ? null
        : DateTime.parse(data['createdAt'] as String),
    updatedAt: data['updatedAt'] == null
        ? null
        : DateTime.parse(data['updatedAt'] as String),
    v: data['__v'] as int?,
  );

  Map<String, dynamic> toMap() => {
    'labId': labId,
    'patientId': patientId,
    'services': services,
    'viaAI': viaAi,
    'status': status,
    'resultFile': resultFile,
    'resultFileType': resultFileType,
    'resultUploadedAt': resultUploadedAt,
    '_id': id,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [NewRequest].
  factory NewRequest.fromJson(String data) {
    return NewRequest.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [NewRequest] to a JSON string.
  String toJson() => json.encode(toMap());

  NewRequest copyWith({
    String? labId,
    String? patientId,
    List<String>? services,
    bool? viaAi,
    String? status,
    List<dynamic>? resultFile,
    dynamic resultFileType,
    dynamic resultUploadedAt,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return NewRequest(
      labId: labId ?? this.labId,
      patientId: patientId ?? this.patientId,
      services: services ?? this.services,
      viaAi: viaAi ?? this.viaAi,
      status: status ?? this.status,
      resultFile: resultFile ?? this.resultFile,
      resultFileType: resultFileType ?? this.resultFileType,
      resultUploadedAt: resultUploadedAt ?? this.resultUploadedAt,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! NewRequest) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      labId.hashCode ^
      patientId.hashCode ^
      services.hashCode ^
      viaAi.hashCode ^
      status.hashCode ^
      resultFile.hashCode ^
      resultFileType.hashCode ^
      resultUploadedAt.hashCode ^
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      v.hashCode;
}
