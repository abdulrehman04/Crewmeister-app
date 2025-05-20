part of '../absence_manager_bloc_test.dart';

class ThrowingFakeRepo implements IAbsenceManagerRepo {
  @override
  Future<PaginatedAbsenceResult> fetchAbsences({
    required int page,
    required int pageSize,
    String? query,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    String? absenceType,
  }) async {
    throw Exception('Network Error 💥');
  }

  @override
  Future<List<AbsenteeItem>> exportAbsences({
    String? query,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    String? absenceType,
  }) async {
    throw Exception('Export Failed');
  }
}
