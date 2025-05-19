part of './bloc.dart';

class _AbsenceManagerDataProvider {
  // A SINGLETON TO SAVE RE-READS OF DATA
  static final _AbsenceManagerDataProvider instance =
      _AbsenceManagerDataProvider._();

  _AbsenceManagerDataProvider._() {
    _apiService = ApiService.instance;
  }

  late ApiService _apiService;

  Future fetchAbsences({
    String? query,
    String? absenceType,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    required int page,
    required int pageSize,
  }) async {
    String response = await _apiService.get(
      'absences',
      queryParams: {
        'query': query,
        'type': absenceType,
        'status': status,
        'page': page.toString(),
        'pageSize': pageSize.toString(),
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
      },
    );

    Map data = jsonDecode(response);
    return data;
  }

  Future exportAbsences({
    String? query,
    String? absenceType,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
  }) async {
    String response = await _apiService.get(
      'export_absences',
      queryParams: {
        'query': query,
        'type': absenceType,
        'status': status,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
      },
    );

    Map data = jsonDecode(response);
    return data;
  }
}
