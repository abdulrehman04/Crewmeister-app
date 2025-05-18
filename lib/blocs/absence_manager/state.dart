// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:crewmeister_app/blocs/absence_manager/bloc.dart';

class AbsenceManagerState extends Equatable {
  final FetchAbsencesState fetchAbsenteesState;
  @override
  List<Object?> get props => [fetchAbsenteesState];

  const AbsenceManagerState({required this.fetchAbsenteesState});

  AbsenceManagerState copyWith({FetchAbsencesState? fetchAbsenteesState}) {
    return AbsenceManagerState(
      fetchAbsenteesState: fetchAbsenteesState ?? this.fetchAbsenteesState,
    );
  }
}

final class AbsenceManagerDefault extends AbsenceManagerState {
  const AbsenceManagerDefault()
    : super(fetchAbsenteesState: const FetchAbsencesDefaultState());
}
