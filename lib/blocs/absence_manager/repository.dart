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

      var out = PaginatedAbsenceResult.fromMap(result);
      return out;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
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
      Map<String, dynamic> result = await dataProvider.exportAbsences(
        query: query,
        absenceType: absenceType,
        startDate: startDate,
        endDate: endDate,
        status: status,
      );
      return List<AbsenteeItem>.from(
        (result['payload']).map<AbsenteeItem>((x) => AbsenteeItem.fromMap(x)),
      );
    } catch (e) {
      rethrow;
    }
  }
}
