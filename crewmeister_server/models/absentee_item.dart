import 'absence_model.dart';
import 'member_model.dart';

class AbsenteeItem {
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

  final String memberName;
  final String memberImage;
  final String type; // "vacation" or "sickness"
  final String status; // "Requested", "Confirmed", "Rejected"
  final String? memberNote;
  final String? admitterNote;
  final DateTime startDate;
  final DateTime endDate;

  static String _resolveStatus(Absence absence) {
    if (absence.confirmedAt != null) return 'Confirmed';
    if (absence.rejectedAt != null) return 'Rejected';
    return 'Requested';
  }

  AbsenteeItem copyWith({
    String? memberName,
    String? memberImage,
    String? type,
    String? status,
    String? memberNote,
    String? admitterNote,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return AbsenteeItem(
      memberName: memberName ?? this.memberName,
      memberImage: memberImage ?? this.memberImage,
      type: type ?? this.type,
      status: status ?? this.status,
      memberNote: memberNote ?? this.memberNote,
      admitterNote: admitterNote ?? this.admitterNote,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'memberName': memberName,
      'memberImage': memberImage,
      'type': type,
      'status': status,
      'memberNote': memberNote,
      'admitterNote': admitterNote,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
    };
  }
}
