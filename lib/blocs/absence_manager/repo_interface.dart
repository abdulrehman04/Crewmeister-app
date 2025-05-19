import 'package:crewmeister_app/blocs/absence_manager/models/absentee_item.dart';
import 'package:crewmeister_app/blocs/absence_manager/models/paginated_absence_result.dart';

abstract class IAbsenceManagerRepo {
  Future<PaginatedAbsenceResult> fetchAbsences({
    required int page,
    required int pageSize,
    String? query,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    String? absenceType,
  });

  Future<List<AbsenteeItem>> exportAbsences({
    String? query,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    String? absenceType,
  });
}
