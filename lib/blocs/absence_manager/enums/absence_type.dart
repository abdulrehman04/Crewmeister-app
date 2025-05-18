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
