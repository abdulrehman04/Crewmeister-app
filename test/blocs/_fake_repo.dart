part of './absence_manager_bloc_test.dart';

class FakeRepo implements IAbsenceManagerRepo {
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
      absences: [
        AbsenteeItem(
          memberImage: 'http://example.com/image.jpg',
          memberName: 'Mike',
          type: 'Vacation',
          startDate: DateTime(2025, 5, 1),
          endDate: DateTime(2025, 5, 3),
          memberNote: 'Going to Spain',
          admitterNote: 'Approved',
          status: 'Confirmed',
        ),
      ],
      hasMore: false,
      totalResults: 1,
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
    return [
      AbsenteeItem(
        memberImage: 'http://example.com/image.jpg',
        memberName: 'Max',
        type: 'Sick Leave',
        startDate: DateTime(2025, 6, 2),
        endDate: DateTime(2025, 6, 3),
        memberNote: 'Fever',
        admitterNote: 'Get well soon',
        status: 'Requested',
      ),
    ];
  }
}
