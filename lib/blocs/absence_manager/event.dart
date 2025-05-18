import 'package:crewmeister_app/models/absence_filters.dart';
import 'package:equatable/equatable.dart';

class AbsenceManagerEvents extends Equatable {
  @override
  List<Object?> get props => [];

  const AbsenceManagerEvents();
}

class FetchAbsencesEvent extends AbsenceManagerEvents {
  // final String? query;
  // final String? absenceType;
  // final DateTime? startDate;
  // final DateTime? endDate;
  // final String? status;
  final int pageSize;

  final AbsenceFilters filters;

  const FetchAbsencesEvent({
    required this.filters,
    // this.query,
    // this.absenceType,
    // this.startDate,
    // this.endDate,
    // this.status,
    required this.pageSize,
  });
}

class FetchAbsenteeCount extends AbsenceManagerEvents {}

class AbsenceManagerTestEvent extends AbsenceManagerEvents {
  const AbsenceManagerTestEvent();
}
