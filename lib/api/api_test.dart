import 'package:test/test.dart';

import 'api.dart';

void main() {
  API api = API();
  group('every member has key', () {
    ['id', 'name', 'userId', 'image'].forEach((key) {
      test(key, () async {
        List<dynamic> memberData = await api.members();
        memberData.forEach((member) {
          expect(member.containsKey(key), isTrue);
        });
      });
    });
  });

  group('every absence has key', () {
    [
      'admitterNote',
      'confirmedAt',
      'createdAt',
      'crewId',
      'endDate',
      'id',
      'memberNote',
      'rejectedAt',
      'startDate',
      'type',
      'userId',
    ].forEach((key) {
      test(key, () async {
        List<dynamic> absenceData = await api.absences();
        absenceData.forEach((absence) {
          expect(absence.containsKey(key), isTrue);
        });
      });
    });
  });
}
