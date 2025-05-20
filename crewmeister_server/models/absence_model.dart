enum AbsenceType {
  vacation,
  sickness;

  String get label {
    switch (this) {
      case AbsenceType.vacation:
        return 'Vacation';
      case AbsenceType.sickness:
        return 'Sick Leave';
    }
  }

  static AbsenceType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'vacation':
        return AbsenceType.vacation;
      case 'sickness':
        return AbsenceType.sickness;
      default:
        throw Exception('Invalid absence type: $value');
    }
  }
}

class Absence {
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
      id: json['id'] as int,
      admitterId: json['admitterId'] != null ? json['admitterId'] as int : null,
      admitterNote:
          json['admitterNote'] != null ? json['admitterNote'] as String : null,
      confirmedAt: json['confirmedAt'] != null
          ? DateTime.parse(json['confirmedAt'] as String)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      crewId: json['crewId'] as int,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      type: AbsenceType.fromString(json['type'] as String),
      memberNote:
          json['memberNote'] != null ? json['memberNote'] as String : null,
      rejectedAt: json['rejectedAt'] != null
          ? DateTime.parse(json['rejectedAt'] as String)
          : null,
      userId: json['userId'] as int,
    );
  }
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
}
