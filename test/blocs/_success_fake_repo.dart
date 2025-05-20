part of '../absence_manager_bloc_test.dart';

class SuccessFakeRepo implements IAbsenceManagerRepo {
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
    return PaginatedAbsenceResult(
      absences: List.generate(
        pageSize,
        (i) => AbsenteeItem(
          memberImage: 'http://example.com/image.jpg',
          memberName: 'Mike',
          type: 'Vacation',
          startDate: DateTime(2025, 5, 1),
          endDate: DateTime(2025, 5, 3),
          memberNote: 'Going to Spain',
          admitterNote: 'Approved',
          status: 'Confirmed',
        ),
      ),
      hasMore: true,
      totalResults: 42,
    );
  }

  @override
  Future<List<AbsenteeItem>> exportAbsences({
    String? query,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    String? absenceType,
  }) async {
    return List.generate(
      42,
      (i) => AbsenteeItem(
        memberImage: 'http://example.com/image.jpg',
        memberName: 'Max',
        type: 'Vacation',
        startDate: DateTime(2025, 5, 1),
        endDate: DateTime(2025, 5, 3),
        memberNote: 'Going to Spain',
        admitterNote: 'Approved',
        status: 'Confirmed',
      ),
    );
  }
}
