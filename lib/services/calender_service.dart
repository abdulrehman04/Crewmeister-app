import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crewmeister_app/blocs/absence_manager/models/absentee_item.dart';

class CalendarService {
  static final instance = CalendarService._();
  CalendarService._();

  String generateICalContentForAbsences({
    required List<AbsenteeItem> absences,
    String productId = "-//Crewmeister//Absence Manager 1.0//EN",
  }) {
    final DateFormat dtFormat = DateFormat("yyyyMMdd");

    final events = absences
        .map((absence) {
          final start = dtFormat.format(absence.startDate.toUtc());
          final end = dtFormat.format(absence.endDate.toUtc());

          return '''
BEGIN:VEVENT
UID:absence_${absence.hashCode}@crewmeister.com
SUMMARY:${_escapeText(absence.type)} - ${_escapeText(absence.memberName)}
DTSTART;VALUE=DATE:$start
DTEND;VALUE=DATE:$end
DESCRIPTION:Member note: ${_escapeText(absence.memberNote ?? '-')}\\nStatus: ${_escapeText(absence.status)}\\nAdmitter note: ${_escapeText(absence.admitterNote ?? '-')}
END:VEVENT
''';
        })
        .join('\n');

    return '''
BEGIN:VCALENDAR
VERSION:2.0
PRODID:$productId
CALSCALE:GREGORIAN
METHOD:PUBLISH
$events
END:VCALENDAR
''';
  }

  Future<File> saveICalToFile(
    String content, {
    String filename = 'absence.ics',
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    return file.writeAsString(content);
  }

  String _escapeText(String input) {
    return input
        .replaceAll('\\', '\\\\')
        .replaceAll('\n', '\\n')
        .replaceAll(',', '\\,')
        .replaceAll(';', '\\;');
  }
}
