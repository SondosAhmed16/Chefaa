import 'dart:convert';

import 'package:collection/collection.dart';

class Pagination {
  int? total;
  int? page;
  int? pages;

  Pagination({this.total, this.page, this.pages});

  @override
  String toString() {
    return 'Pagination(total: $total, page: $page, pages: $pages)';
  }

  factory Pagination.fromMap(Map<String, dynamic> data) => Pagination(
    total: data['total'] as int?,
    page: data['page'] as int?,
    pages: data['pages'] as int?,
  );

  Map<String, dynamic> toMap() => {
    'total': total,
    'page': page,
    'pages': pages,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Pagination].
  factory Pagination.fromJson(String data) {
    return Pagination.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Pagination] to a JSON string.
  String toJson() => json.encode(toMap());

  Pagination copyWith({int? total, int? page, int? pages}) {
    return Pagination(
      total: total ?? this.total,
      page: page ?? this.page,
      pages: pages ?? this.pages,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Pagination) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => total.hashCode ^ page.hashCode ^ pages.hashCode;
}
