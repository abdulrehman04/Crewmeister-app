import 'package:equatable/equatable.dart';

class AbsenceFilters extends Equatable {
  final String? query;
  final String? absenceType;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;

  const AbsenceFilters({
    this.query,
    this.absenceType,
    this.startDate,
    this.endDate,
    this.status,
  });

  @override
  List<Object?> get props => [query, absenceType, startDate, endDate, status];

  AbsenceFilters copyWith({
    String? query,
    String? absenceType,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
  }) {
    return AbsenceFilters(
      query: query ?? this.query,
      absenceType: absenceType ?? this.absenceType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
    );
  }
}
