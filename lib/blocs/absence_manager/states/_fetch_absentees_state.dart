part of '../absence_manager_bloc.dart';

class FetchAbsencesState extends Equatable {
  static bool match(AbsenceManagerState a, AbsenceManagerState b) =>
      a.fetchAbsenteesState != b.fetchAbsenteesState;

  final List<AbsenteeItem> absences;
  final bool hasMore;
  final String? message;

  const FetchAbsencesState({
    this.absences = const [],
    this.message,
    this.hasMore = false,
  });

  @override
  List<Object?> get props => [absences, message, hasMore];
}

class FetchAbsencesDefaultState extends FetchAbsencesState {
  const FetchAbsencesDefaultState();
}

class FetchAbsencesLoadingState extends FetchAbsencesState {
  const FetchAbsencesLoadingState({super.absences, super.hasMore});
}

class FetchAbsencesSuccessState extends FetchAbsencesState {
  final int totalResults;
  const FetchAbsencesSuccessState({
    required super.absences,
    required super.hasMore,
    required this.totalResults,
  });
}

class FetchAbsencesFailureState extends FetchAbsencesState {
  const FetchAbsencesFailureState({required super.message});
}
