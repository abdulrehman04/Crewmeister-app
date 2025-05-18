part of './bloc.dart';

class _AbsenceManagerRepo {
  final dataProvider = _AbsenceManagerDataProvider.instance;

  testCall() {
    dataProvider.testCall();
  }

  Future<List<AbsenteeItem>> fetchAbsences({
    String? query,
    AbsenceType? absenceType,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    required int page,
    required int pageSize,
  }) {
    try {
      return dataProvider.fetchAbsences(
        query: query,
        absenceType: absenceType,
        startDate: startDate,
        endDate: endDate,
        status: status,
        page: page,
        pageSize: pageSize,
      );
    } catch (e) {
      rethrow;
    }
  }
}
