import 'package:crewmeister_app/models/absence_filters.dart';
import 'package:equatable/equatable.dart';

class AbsenceManagerEvents extends Equatable {
  @override
  List<Object?> get props => [];

  const AbsenceManagerEvents();
}

class FetchAbsencesEvent extends AbsenceManagerEvents {
  final int pageSize;
  final AbsenceFilters filters;

  const FetchAbsencesEvent({required this.filters, required this.pageSize});
}

class ExportAbsencesEvent extends AbsenceManagerEvents {
  final AbsenceFilters filters;

  const ExportAbsencesEvent({required this.filters});
}
