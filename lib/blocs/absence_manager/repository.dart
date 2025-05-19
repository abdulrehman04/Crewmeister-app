part of './bloc.dart';

class _AbsenceManagerRepo implements IAbsenceManagerRepo {
  final dataProvider = _AbsenceManagerDataProvider.instance;

  @override
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
      Map<String, dynamic> result = await dataProvider.fetchAbsences(
        query: query,
        absenceType: absenceType,
        startDate: startDate,
        endDate: endDate,
        status: status,
        page: page,
        pageSize: pageSize,
      );

      print(result);

      var out = PaginatedAbsenceResult.fromMap(result);
      return out;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
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
