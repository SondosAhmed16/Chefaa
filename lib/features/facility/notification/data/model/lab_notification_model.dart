import 'dart:convert';
import 'dart:core';

import 'package:collection/collection.dart';

import 'new.dart';

class LabNotificationModel {
  int? unreadCount;
  List<New>? news;
  List<dynamic>? earlier;

  LabNotificationModel({this.unreadCount, this.news, this.earlier});

  @override
  String toString() {
    return 'LabNotificationModel(unreadCount: $unreadCount, news: $news, earlier: $earlier)';
  }

  factory LabNotificationModel.fromMap(Map<String, dynamic> data) {
    return LabNotificationModel(
      unreadCount: data['unreadCount'] as int?,
      news: (data['new'] as List<dynamic>?)
          ?.map((e) => New.fromMap(e as Map<String, dynamic>))
          .toList(),
      earlier: data['earlier'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toMap() => {
    'unreadCount': unreadCount,
    'new': news?.map((e) => e.toMap()).toList(),
    'earlier': earlier,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LabNotificationModel].
  factory LabNotificationModel.fromJson(String data) {
    return LabNotificationModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [LabNotificationModel] to a JSON string.
  String toJson() => json.encode(toMap());

  LabNotificationModel copyWith({
    int? unreadCount,
    List<New>? news,
    List<dynamic>? earlier,
  }) {
    return LabNotificationModel(
      unreadCount: unreadCount ?? this.unreadCount,
      news: news ?? this.news,
      earlier: earlier ?? this.earlier,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LabNotificationModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => unreadCount.hashCode ^ news.hashCode ^ earlier.hashCode;
}
