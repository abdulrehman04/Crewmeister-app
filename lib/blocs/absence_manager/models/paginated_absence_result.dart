// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:crewmeister_app/blocs/absence_manager/models/absentee_item.dart';

class PaginatedAbsenceResult {
  final List<AbsenteeItem> absences;
  final bool hasMore;
  final int totalResults;

  PaginatedAbsenceResult({
    required this.absences,
    required this.hasMore,
    required this.totalResults,
  });

  PaginatedAbsenceResult copyWith({
    List<AbsenteeItem>? absences,
    bool? hasMore,
    int? totalResults,
  }) {
    return PaginatedAbsenceResult(
      absences: absences ?? this.absences,
      hasMore: hasMore ?? this.hasMore,
      totalResults: totalResults ?? this.totalResults,
    );
  }

  factory PaginatedAbsenceResult.fromMap(Map<String, dynamic> map) {
    return PaginatedAbsenceResult(
      absences: List<AbsenteeItem>.from(
        (map['payload']).map<AbsenteeItem>((x) => AbsenteeItem.fromMap(x)),
      ),
      hasMore: map['hasMore'] as bool,
      totalResults: map['totalResults'] as int,
    );
  }

  factory PaginatedAbsenceResult.fromJson(String source) =>
      PaginatedAbsenceResult.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'PaginatedAbsenceResult(absences: $absences, hasMore: $hasMore, totalResults: $totalResults)';

  @override
  bool operator ==(covariant PaginatedAbsenceResult other) {
    if (identical(this, other)) return true;

    return listEquals(other.absences, absences) &&
        other.hasMore == hasMore &&
        other.totalResults == totalResults;
  }

  @override
  int get hashCode =>
      absences.hashCode ^ hasMore.hashCode ^ totalResults.hashCode;
}
