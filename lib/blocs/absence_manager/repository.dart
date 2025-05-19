part of './bloc.dart';

class _AbsenceManagerRepo {
  final dataProvider = _AbsenceManagerDataProvider.instance;

  Future<PaginatedAbsenceResult> fetchAbsences({
    String? query,
    String? absenceType,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    required int page,
    required int pageSize,
  }) async {
    try {
      return await dataProvider.fetchAbsences(
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

  Future<List<AbsenteeItem>> exportAbsences({
    String? query,
    String? absenceType,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
  }) async {
    try {
      return await dataProvider.exportAbsences(
        query: query,
        absenceType: absenceType,
        startDate: startDate,
        endDate: endDate,
        status: status,
      );
    } catch (e) {
      rethrow;
    }
  }
}
