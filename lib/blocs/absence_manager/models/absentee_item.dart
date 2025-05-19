// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  factory AbsenteeItem.fromMap(Map<String, dynamic> map) {
    return AbsenteeItem(
      memberName: map['memberName'] as String,
      memberImage: map['memberImage'] as String,
      type: map['type'] as String,
      status: map['status'] as String,
      memberNote:
          map['memberNote'] != null ? map['memberNote'] as String : null,
      admitterNote:
          map['admitterNote'] != null ? map['admitterNote'] as String : null,
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory AbsenteeItem.fromJson(String source) =>
      AbsenteeItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AbsenteeItem(memberName: $memberName, memberImage: $memberImage, type: $type, status: $status, memberNote: $memberNote, admitterNote: $admitterNote, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(covariant AbsenteeItem other) {
    if (identical(this, other)) return true;

    return other.memberName == memberName &&
        other.memberImage == memberImage &&
        other.type == type &&
        other.status == status &&
        other.memberNote == memberNote &&
        other.admitterNote == admitterNote &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return memberName.hashCode ^
        memberImage.hashCode ^
        type.hashCode ^
        status.hashCode ^
        memberNote.hashCode ^
        admitterNote.hashCode ^
        startDate.hashCode ^
        endDate.hashCode;
  }
}
