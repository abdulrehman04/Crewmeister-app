import 'dart:async';

import 'package:crewmeister_app/blocs/absence_manager/enums/absence_type.dart';
import 'package:crewmeister_app/blocs/absence_manager/event.dart';
import 'package:crewmeister_app/blocs/absence_manager/models/absence_model.dart';
import 'package:crewmeister_app/blocs/absence_manager/models/absentee_item.dart';
import 'package:crewmeister_app/blocs/absence_manager/models/member_model.dart';
import 'package:crewmeister_app/blocs/absence_manager/models/paginated_absence_result.dart';
import 'package:crewmeister_app/blocs/absence_manager/state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../absence_manager/../../api/api.dart';

part './repository.dart';
part './data_provider.dart';
part './states/_fetch_absentees_state.dart';

class AbsenceManagerBloc
    extends Bloc<AbsenceManagerEvents, AbsenceManagerState> {
  AbsenceManagerBloc() : super(const AbsenceManagerDefault()) {
    on<AbsenceManagerTestEvent>(_onTestCall);
    on<FetchAbsencesEvent>(_onFetchAbsences);
  }

  final _repo = _AbsenceManagerRepo();
  int _currentPage = 1;

  FutureOr<void> _onTestCall(
    AbsenceManagerTestEvent event,
    Emitter<AbsenceManagerState> emit,
  ) {
    _repo.testCall();
  }

  Future<void> _onFetchAbsences(
    FetchAbsencesEvent event,
    Emitter<AbsenceManagerState> emit,
  ) async {
    final prevAbsences = state.fetchAbsenteesState.absences;
    emit(
      state.copyWith(
        fetchAbsenteesState: FetchAbsencesLoadingState(absences: prevAbsences),
      ),
    );
    try {
      PaginatedAbsenceResult result = await _repo.fetchAbsences(
        page: _currentPage,
        pageSize: event.pageSize,
        query: event.query,
        startDate: event.startDate,
        endDate: event.endDate,
        status: event.status,
        absenceType: event.absenceType,
      );
      _currentPage++;
      emit(
        state.copyWith(
          fetchAbsenteesState: FetchAbsencesSuccessState(
            absences: [...prevAbsences, ...result.absences],
            hasMore: result.hasMore,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          fetchAbsenteesState: FetchAbsencesFailureState(message: e.toString()),
        ),
      );
    }
  }
}
