import 'package:crewmeister_app/blocs/absence_manager/event.dart';
import 'package:crewmeister_app/blocs/absence_manager/models/absentee_item.dart';
import 'package:crewmeister_app/blocs/absence_manager/models/paginated_absence_result.dart';
import 'package:crewmeister_app/blocs/absence_manager/absence_manager_repo_interface.dart';
import 'package:crewmeister_app/blocs/absence_manager/state.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:crewmeister_app/blocs/absence_manager/absence_manager_bloc.dart';
import 'package:crewmeister_app/models/absence_filters.dart';

part 'blocs/_error_throw_fake_repo.dart';
part 'blocs/_success_fake_repo.dart';

void main() {
  group('AbsenceManagerBloc Success', () {
    late AbsenceManagerBloc bloc;

    setUp(() {
      bloc = AbsenceManagerBloc(repo: SuccessFakeRepo());
    });

    test('initial state is AbsenceManagerDefault', () {
      expect(bloc.state, isA<AbsenceManagerDefault>());
    });

    test('initial state has default substates of fetch and export states', () {
      final bloc = AbsenceManagerBloc(repo: SuccessFakeRepo());
      final state = bloc.state;

      expect(state.fetchAbsenteesState, isA<FetchAbsencesDefaultState>());
      expect(state.exportAbsencesState, isA<ExportAbsencesDefaultState>());
    });

    test('emits loading then success on fetchAbsences', () async {
      final emitted = <AbsenceManagerState>[];

      final sub = bloc.stream.listen((state) {
        emitted.add(state);
      });

      bloc.add(FetchAbsencesEvent(pageSize: 10, filters: AbsenceFilters()));

      await Future.delayed(Duration(milliseconds: 300));
      await sub.cancel();

      expect(emitted[0].fetchAbsenteesState, isA<FetchAbsencesLoadingState>());
      expect(emitted[1].fetchAbsenteesState, isA<FetchAbsencesSuccessState>());

      final absences =
          (emitted[1].fetchAbsenteesState as FetchAbsencesSuccessState)
              .absences;
      expect(absences.length, 10);
      expect(absences.first.memberName, 'Mike');
    });

    test('emits loading then success on exportAbsences', () async {
      final emitted = <AbsenceManagerState>[];

      final sub = bloc.stream.listen(emitted.add);

      bloc.add(ExportAbsencesEvent(filters: AbsenceFilters()));

      await Future.delayed(Duration(milliseconds: 300));
      await sub.cancel();

      expect(emitted[0].exportAbsencesState, isA<ExportAbsencesLoadingState>());
      expect(emitted[1].exportAbsencesState, isA<ExportAbsencesSuccessState>());

      final exported =
          (emitted[1].exportAbsencesState as ExportAbsencesSuccessState)
              .absences;
      expect(exported.length, 42);
      expect(exported.first.memberName, 'Max');
    });

    test(
      'exportAbsences fetches all results for a filter, not only visible ones from fetchAbsentee',
      () async {
        final bloc = AbsenceManagerBloc(repo: SuccessFakeRepo());
        final emitted = <AbsenceManagerState>[];
        final sub = bloc.stream.listen(emitted.add);

        final filters = AbsenceFilters(query: 'max');

        bloc.add(ExportAbsencesEvent(filters: filters));
        await Future.delayed(Duration(milliseconds: 300));
        await sub.cancel();

        final state = emitted.last.exportAbsencesState;
        expect(state, isA<ExportAbsencesSuccessState>());

        final exported = (state as ExportAbsencesSuccessState).absences;

        expect(
          exported.length,
          greaterThan(10),
        ); // 'Export should fetch all matches, not just 1 page'
        expect(exported.first.memberName.toLowerCase(), contains('max'));
      },
    );

    test('pagination appends absences on same filter', () async {
      final bloc = AbsenceManagerBloc(repo: SuccessFakeRepo());
      final emitted = <AbsenceManagerState>[];
      final sub = bloc.stream.listen(emitted.add);

      // First fetch
      bloc.add(FetchAbsencesEvent(pageSize: 10, filters: AbsenceFilters()));
      await Future.delayed(Duration(milliseconds: 200));

      // Second fetch with same filters (simulate pagination)
      bloc.add(FetchAbsencesEvent(pageSize: 10, filters: AbsenceFilters()));
      await Future.delayed(Duration(milliseconds: 200));
      await sub.cancel();

      final successStates =
          emitted
              .map((e) => e.fetchAbsenteesState)
              .whereType<FetchAbsencesSuccessState>()
              .toList();

      expect(successStates.last.absences.length, 20);
    });

    test(
      'when filters change, absences list resets (no accumulation)',
      () async {
        final bloc = AbsenceManagerBloc(repo: SuccessFakeRepo());
        final emitted = <AbsenceManagerState>[];
        final sub = bloc.stream.listen(emitted.add);

        // First fetch with default filters
        bloc.add(FetchAbsencesEvent(pageSize: 10, filters: AbsenceFilters()));
        await Future.delayed(Duration(milliseconds: 200));

        // Fetch again with different filters
        bloc.add(
          FetchAbsencesEvent(
            pageSize: 10,
            filters: AbsenceFilters(query: 'max'),
          ),
        );
        await Future.delayed(Duration(milliseconds: 200));

        await sub.cancel();

        final successStates =
            emitted
                .map((e) => e.fetchAbsenteesState)
                .whereType<FetchAbsencesSuccessState>()
                .toList();

        // First fetch should have 1 item
        expect(successStates[0].absences.length, 10);
        expect(successStates[0].absences.first.memberName, contains('Mike'));

        // Second fetch should NOT accumulate
        expect(successStates[1].absences.length, 10);
      },
    );

    test(
      'Initial fetch emits success with correct number of absences',
      () async {
        final bloc = AbsenceManagerBloc(repo: SuccessFakeRepo());
        final emitted = <AbsenceManagerState>[];

        final sub = bloc.stream.listen(emitted.add);

        bloc.add(FetchAbsencesEvent(pageSize: 5, filters: AbsenceFilters()));

        await Future.delayed(Duration(milliseconds: 300));
        await sub.cancel();

        final success =
            emitted.last.fetchAbsenteesState as FetchAbsencesSuccessState;

        expect(success.absences.length, 5);
        expect(success.hasMore, true);
      },
    );
  });

  group('Absence manager error throwing bloc', () {
    test('emits loading then failure on fetchAbsences error', () async {
      final bloc = AbsenceManagerBloc(repo: ThrowingFakeRepo());
      final emitted = <AbsenceManagerState>[];
      final sub = bloc.stream.listen(emitted.add);

      bloc.add(FetchAbsencesEvent(pageSize: 10, filters: AbsenceFilters()));
      await Future.delayed(Duration(milliseconds: 300));
      await sub.cancel();

      expect(emitted[0].fetchAbsenteesState, isA<FetchAbsencesLoadingState>());
      expect(emitted[1].fetchAbsenteesState, isA<FetchAbsencesFailureState>());
      expect(
        (emitted[1].fetchAbsenteesState as FetchAbsencesFailureState).message,
        contains('Network Error'),
      );
    });

    test('emits loading then failure on exportAbsences error', () async {
      final bloc = AbsenceManagerBloc(repo: ThrowingFakeRepo());
      final emitted = <AbsenceManagerState>[];
      final sub = bloc.stream.listen(emitted.add);

      bloc.add(ExportAbsencesEvent(filters: AbsenceFilters()));
      await Future.delayed(Duration(milliseconds: 300));
      await sub.cancel();

      expect(emitted[0].exportAbsencesState, isA<ExportAbsencesLoadingState>());
      expect(emitted[1].exportAbsencesState, isA<ExportAbsencesFailureState>());
      expect(
        (emitted[1].exportAbsencesState as ExportAbsencesFailureState).message,
        contains('Export Failed'),
      );
    });
  });
}
