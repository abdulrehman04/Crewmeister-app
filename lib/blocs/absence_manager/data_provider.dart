part of './bloc.dart';

class _AbsenceManagerDataProvider {
  // A SINGLETON TO SAVE RE-READS OF DATA
  static final _AbsenceManagerDataProvider instance =
      _AbsenceManagerDataProvider._();
  _AbsenceManagerDataProvider._() {
    readInitialData();
  }

  List members = [];
  List absences = [];

  Future<void> readInitialData() async {
    API api = API();
    print(await api.absences());
    print(await api.members());
  }

  testCall() {
    print("this is test call");
  }
}
