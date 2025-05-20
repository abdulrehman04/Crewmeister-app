import 'package:equatable/equatable.dart';

import 'package:crewmeister_app/blocs/absence_manager/absence_manager_bloc.dart';

class AbsenceManagerState extends Equatable {
  final FetchAbsencesState fetchAbsenteesState;
  final ExportAbsencesState exportAbsencesState;

  @override
  List<Object?> get props => [fetchAbsenteesState, exportAbsencesState];

  const AbsenceManagerState({
    required this.fetchAbsenteesState,
    required this.exportAbsencesState,
  });

  AbsenceManagerState copyWith({
    FetchAbsencesState? fetchAbsenteesState,
    ExportAbsencesState? exportAbsencesState,
  }) {
    return AbsenceManagerState(
      fetchAbsenteesState: fetchAbsenteesState ?? this.fetchAbsenteesState,
      exportAbsencesState: exportAbsencesState ?? this.exportAbsencesState,
    );
  }
}

final class AbsenceManagerDefault extends AbsenceManagerState {
  const AbsenceManagerDefault()
    : super(
        fetchAbsenteesState: const FetchAbsencesDefaultState(),
        exportAbsencesState: const ExportAbsencesDefaultState(),
      );
}
