import 'package:crewmeister_app/blocs/absence_manager/models/absence_model.dart';
import 'package:crewmeister_app/blocs/absence_manager/models/member_model.dart';

class AbsenteeItem {
  final String memberName;
  final String memberImage;
  final String type; // "vacation" or "sickness"
  final String status; // "Requested", "Confirmed", "Rejected"
  final String? memberNote;
  final String? admitterNote;
  final DateTime startDate;
  final DateTime endDate;

  AbsenteeItem({
    required this.memberName,
    required this.memberImage,
    required this.type,
    required this.status,
    required this.memberNote,
    required this.admitterNote,
    required this.startDate,
    required this.endDate,
  });

  // merge Absence + Member into AbsenteeItem
  factory AbsenteeItem.fromAbsenceAndMember({
    required Absence absence,
    required Member member,
  }) {
    final status = _resolveStatus(absence);

    return AbsenteeItem(
      memberName: member.name,
      memberImage: member.image,
      type: absence.type.label,
      status: status,
      memberNote: absence.memberNote,
      admitterNote: absence.admitterNote,
      startDate: absence.startDate,
      endDate: absence.endDate,
    );
  }

  static String _resolveStatus(Absence absence) {
    if (absence.confirmedAt != null) return "Confirmed";
    if (absence.rejectedAt != null) return "Rejected";
    return "Requested";
  }
}
