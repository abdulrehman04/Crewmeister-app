part of '../bloc.dart';

class FetchAbsencesState extends Equatable {
  static bool match(AbsenceManagerState a, AbsenceManagerState b) =>
      a.fetchAbsenteesState != b.fetchAbsenteesState;

  final List<AbsenteeItem> absences;
  final String? message;

  const FetchAbsencesState({this.absences = const [], this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchAbsencesDefaultState extends FetchAbsencesState {
  const FetchAbsencesDefaultState();
}

class FetchAbsencesLoadingState extends FetchAbsencesState {
  const FetchAbsencesLoadingState();
}

class FetchAbsencesSuccessState extends FetchAbsencesState {
  const FetchAbsencesSuccessState({required super.absences});
}

class FetchAbsencesFailureState extends FetchAbsencesState {
  const FetchAbsencesFailureState({required super.message});
}
