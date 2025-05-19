import 'package:crewmeister_app/blocs/absence_manager/event.dart';
import 'package:crewmeister_app/blocs/absence_manager/models/absentee_item.dart';
import 'package:crewmeister_app/blocs/absence_manager/models/paginated_absence_result.dart';
import 'package:crewmeister_app/blocs/absence_manager/repo_interface.dart';
import 'package:crewmeister_app/blocs/absence_manager/state.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:crewmeister_app/blocs/absence_manager/bloc.dart';
import 'package:crewmeister_app/models/absence_filters.dart';
part './_fake_repo.dart';

void main() {
  group('AbsenceManagerBloc', () {
    late AbsenceManagerBloc bloc;

    setUp(() {
      bloc = AbsenceManagerBloc(repo: FakeRepo());
    });

    test('initial state is AbsenceManagerDefault', () {
      expect(bloc.state, isA<AbsenceManagerDefault>());
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
      expect(absences.length, 1);
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
      expect(exported.length, 1);
      expect(exported.first.memberName, 'Max');
    });
  });
}
