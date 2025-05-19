import 'dart:async';

import 'package:crewmeister_app/blocs/absence_manager/event.dart';
import 'package:crewmeister_app/blocs/absence_manager/models/absence_model.dart';
import 'package:crewmeister_app/blocs/absence_manager/models/absentee_item.dart';
import 'package:crewmeister_app/blocs/absence_manager/models/member_model.dart';
import 'package:crewmeister_app/blocs/absence_manager/models/paginated_absence_result.dart';
import 'package:crewmeister_app/blocs/absence_manager/repo_interface.dart';
import 'package:crewmeister_app/blocs/absence_manager/state.dart';
import 'package:crewmeister_app/models/absence_filters.dart';
import 'package:crewmeister_app/services/api_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../absence_manager/../../api/api.dart';

part './repository.dart';
part './data_provider.dart';
part './states/_fetch_absentees_state.dart';
part './states/_export_absences_state.dart';

class AbsenceManagerBloc
    extends Bloc<AbsenceManagerEvents, AbsenceManagerState> {
  AbsenceManagerBloc({required IAbsenceManagerRepo repo})
    : _repo = repo,
      super(const AbsenceManagerDefault()) {
    on<FetchAbsencesEvent>(_onFetchAbsences);
    on<ExportAbsencesEvent>(_onExportAbsences);
  }

  factory AbsenceManagerBloc.withDefaultRepo() {
    return AbsenceManagerBloc(repo: _AbsenceManagerRepo());
  }

  final IAbsenceManagerRepo _repo;
  int _currentPage = 1;
  AbsenceFilters _currentFilters = AbsenceFilters();

  Future<void> _onFetchAbsences(
    FetchAbsencesEvent event,
    Emitter<AbsenceManagerState> emit,
  ) async {
    List<AbsenteeItem> prevAbsences = state.fetchAbsenteesState.absences;
    emit(
      state.copyWith(
        fetchAbsenteesState: FetchAbsencesLoadingState(absences: prevAbsences),
      ),
    );
    try {
      final isFilterChanged = event.filters != _currentFilters;

      if (isFilterChanged) {
        _currentPage = 1;
        _currentFilters = event.filters;
        prevAbsences = [];
      }
      PaginatedAbsenceResult result = await _repo.fetchAbsences(
        page: _currentPage,
        pageSize: event.pageSize,
        query: event.filters.query,
        startDate: event.filters.startDate,
        endDate: event.filters.endDate,
        status: event.filters.status,
        absenceType: event.filters.absenceType,
      );
      _currentPage++;
      emit(
        state.copyWith(
          fetchAbsenteesState: FetchAbsencesSuccessState(
            absences: [...prevAbsences, ...result.absences],
            hasMore: result.hasMore,
            totalResults: result.totalResults,
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

  Future<void> _onExportAbsences(
    ExportAbsencesEvent event,
    Emitter<AbsenceManagerState> emit,
  ) async {
    emit(state.copyWith(exportAbsencesState: ExportAbsencesLoadingState()));
    try {
      final result = await _repo.exportAbsences(
        query: event.filters.query,
        startDate: event.filters.startDate,
        endDate: event.filters.endDate,
        status: event.filters.status,
        absenceType: event.filters.absenceType,
      );
      emit(
        state.copyWith(
          exportAbsencesState: ExportAbsencesSuccessState(absences: result),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          exportAbsencesState: ExportAbsencesFailureState(
            message: e.toString(),
          ),
        ),
      );
    }
  }
}
