import 'package:crewmeister_app/blocs/absence_manager/models/absentee_item.dart';

class PaginatedAbsenceResult {
  final List<AbsenteeItem> absences;
  final bool hasMore;

  PaginatedAbsenceResult({required this.absences, required this.hasMore});
}
