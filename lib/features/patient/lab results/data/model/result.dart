import 'dart:convert';

import 'package:collection/collection.dart';

class Result {
  String? requestId;
  String? fileName;
  String? labName;
  DateTime? uploadedAt;
  String? fileUrl;
  String? fileType;
  String? doctorNotes;

  Result({
    this.requestId,
    this.fileName,
    this.labName,
    this.uploadedAt,
    this.fileUrl,
    this.fileType,
    this.doctorNotes,
  });

  @override
  String toString() {
    return 'Result(requestId: $requestId, fileName: $fileName, labName: $labName, uploadedAt: $uploadedAt, fileUrl: $fileUrl, fileType: $fileType, doctorNotes: $doctorNotes)';
  }

  factory Result.fromMap(Map<String, dynamic> data) => Result(
    requestId: data['requestId'] as String?,
    fileName: data['fileName'] as String?,
    labName: data['labName'] as String?,
    uploadedAt: data['uploadedAt'] == null
        ? null
        : DateTime.parse(data['uploadedAt'] as String),
    fileUrl: data['fileUrl'] as String?,
    fileType: data['fileType'] as String?,
    doctorNotes: data['doctorNotes'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'requestId': requestId,
    'fileName': fileName,
    'labName': labName,
    'uploadedAt': uploadedAt?.toIso8601String(),
    'fileUrl': fileUrl,
    'fileType': fileType,
    'doctorNotes': doctorNotes,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Result].
  factory Result.fromJson(String data) {
    return Result.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Result] to a JSON string.
  String toJson() => json.encode(toMap());

  Result copyWith({
    String? requestId,
    String? fileName,
    String? labName,
    DateTime? uploadedAt,
    String? fileUrl,
    String? fileType,
    String? doctorNotes,
  }) {
    return Result(
      requestId: requestId ?? this.requestId,
      fileName: fileName ?? this.fileName,
      labName: labName ?? this.labName,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      fileUrl: fileUrl ?? this.fileUrl,
      fileType: fileType ?? this.fileType,
      doctorNotes: doctorNotes ?? this.doctorNotes,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Result) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      requestId.hashCode ^
      fileName.hashCode ^
      labName.hashCode ^
      uploadedAt.hashCode ^
      fileUrl.hashCode ^
      fileType.hashCode ^
      doctorNotes.hashCode;
}
