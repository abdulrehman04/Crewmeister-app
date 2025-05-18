part of './bloc.dart';

class _AbsenceManagerRepo {
  final dataProvider = _AbsenceManagerDataProvider.instance;

  testCall() {
    dataProvider.testCall();
  }
}
