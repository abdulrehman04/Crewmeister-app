import 'package:crewmeister_app/blocs/absence_manager/enums/absence_type.dart';

class Absence {
  final int id;
  final int? admitterId;
  final String? admitterNote;
  final DateTime? confirmedAt;
  final DateTime createdAt;
  final int crewId;
  final DateTime startDate;
  final DateTime endDate;
  final AbsenceType type; // "sickness" or "vacation"
  final String? memberNote;
  final DateTime? rejectedAt;
  final int userId;

  Absence({
    required this.id,
    required this.admitterId,
    required this.admitterNote,
    required this.confirmedAt,
    required this.createdAt,
    required this.crewId,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.memberNote,
    required this.rejectedAt,
    required this.userId,
  });

  factory Absence.fromJson(Map<String, dynamic> json) {
    return Absence(
      id: json['id'],
      admitterId: json['admitterId'],
      admitterNote: json['admitterNote'],
      confirmedAt:
          json['confirmedAt'] != null
              ? DateTime.parse(json['confirmedAt'])
              : null,
      createdAt: DateTime.parse(json['createdAt']),
      crewId: json['crewId'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      type: AbsenceType.fromString(json['type']),
      memberNote: json['memberNote'],
      rejectedAt:
          json['rejectedAt'] != null
              ? DateTime.parse(json['rejectedAt'])
              : null,
      userId: json['userId'],
    );
  }
}
