import 'dart:convert';

import 'package:collection/collection.dart';

import 'profile_data.dart';

class LabProfileResponse {
  bool? success;
  ProfileData? profileData;

  LabProfileResponse({this.success, this.profileData});

  @override
  String toString() {
    return 'LabProfileResponse(success: $success, profileData: $profileData)';
  }

  factory LabProfileResponse.fromMap(Map<String, dynamic> data) {
    return LabProfileResponse(
      success: data['success'] as bool?,
      profileData: data['profileData'] == null
          ? null
          : ProfileData.fromMap(data['profileData'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
    'success': success,
    'profileData': profileData?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LabProfileResponse].
  factory LabProfileResponse.fromJson(String data) {
    return LabProfileResponse.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [LabProfileResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  LabProfileResponse copyWith({bool? success, ProfileData? profileData}) {
    return LabProfileResponse(
      success: success ?? this.success,
      profileData: profileData ?? this.profileData,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LabProfileResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ profileData.hashCode;
}
