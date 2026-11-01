import 'dart:convert';

import 'package:collection/collection.dart';

class Data {
  String? question;
  String? answer;

  Data({this.question, this.answer});

  @override
  String toString() => 'Data(question: $question, answer: $answer)';

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    question: data['question'] as String?,
    answer: data['answer'] as String?,
  );

  Map<String, dynamic> toMap() => {'question': question, 'answer': answer};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({String? question, String? answer}) {
    return Data(
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => question.hashCode ^ answer.hashCode;
}
