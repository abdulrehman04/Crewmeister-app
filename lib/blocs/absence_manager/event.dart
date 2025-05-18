// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:crewmeister_app/blocs/absence_manager/enums/absence_type.dart';

class AbsenceManagerEvents extends Equatable {
  @override
  List<Object?> get props => [];

  const AbsenceManagerEvents();
}

class FetchAbsenteesEvent extends AbsenceManagerEvents {
  final String? query;
  final AbsenceType? absenceType;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;
  final int page;
  final int pageSize;

  const FetchAbsenteesEvent({
    this.query,
    this.absenceType,
    this.startDate,
    this.endDate,
    this.status,
    required this.page,
    required this.pageSize,
  });
}

class FetchAbsenteeCount extends AbsenceManagerEvents {}

class AbsenceManagerTestEvent extends AbsenceManagerEvents {
  const AbsenceManagerTestEvent();
}
