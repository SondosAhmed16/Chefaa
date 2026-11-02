import 'dart:convert';

import 'package:collection/collection.dart';

import 'new_service.dart';

class AddServiceModel {
  String? message;
  NewService? newService;

  AddServiceModel({this.message, this.newService});

  @override
  String toString() {
    return 'AddServiceModel(message: $message, newService: $newService)';
  }

  factory AddServiceModel.fromMap(Map<String, dynamic> data) {
    return AddServiceModel(
      message: data['message'] as String?,
      newService: data['newService'] == null
          ? null
          : NewService.fromMap(data['newService'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
    'message': message,
    'newService': newService?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AddServiceModel].
  factory AddServiceModel.fromJson(String data) {
    return AddServiceModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AddServiceModel] to a JSON string.
  String toJson() => json.encode(toMap());

  AddServiceModel copyWith({String? message, NewService? newService}) {
    return AddServiceModel(
      message: message ?? this.message,
      newService: newService ?? this.newService,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AddServiceModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => message.hashCode ^ newService.hashCode;
}
