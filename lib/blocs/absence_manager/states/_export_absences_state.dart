part of '../bloc.dart';

class ExportAbsencesState extends Equatable {
  static bool match(AbsenceManagerState a, AbsenceManagerState b) =>
      a.exportAbsencesState != b.exportAbsencesState;

  final List<AbsenteeItem> absences;
  final String? message;
  const ExportAbsencesState({this.absences = const [], this.message});

  @override
  List<Object?> get props => [absences, message];
}

class ExportAbsencesDefaultState extends ExportAbsencesState {
  const ExportAbsencesDefaultState();
}

class ExportAbsencesLoadingState extends ExportAbsencesState {
  const ExportAbsencesLoadingState();
}

class ExportAbsencesSuccessState extends ExportAbsencesState {
  const ExportAbsencesSuccessState({required super.absences});
}

class ExportAbsencesFailureState extends ExportAbsencesState {
  const ExportAbsencesFailureState({required super.message});
}
