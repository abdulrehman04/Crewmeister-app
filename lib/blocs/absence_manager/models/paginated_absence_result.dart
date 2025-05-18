import 'package:crewmeister_app/blocs/absence_manager/models/absentee_item.dart';

class PaginatedAbsenceResult {
  final List<AbsenteeItem> absences;
  final bool hasMore;
  final int totalResults;

  PaginatedAbsenceResult({
    required this.absences,
    required this.hasMore,
    required this.totalResults,
  });
}
