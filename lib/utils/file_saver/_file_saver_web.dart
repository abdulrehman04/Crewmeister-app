import 'dart:convert';

import 'package:web/web.dart' as web;

void downloadICalFile(String icsContent) {
  final encoded = utf8.encode(icsContent);
  final base64Content = base64Encode(encoded);
  final dataUrl = 'data:text/calendar;base64,$base64Content';

  final anchor =
      web.document.createElement('a') as web.HTMLAnchorElement
        ..href = dataUrl
        ..download = 'Absences - ${DateTime.now().toIso8601String()}.ics'
        ..style.display = 'none';

  web.document.body!.append(anchor);
  anchor.click();
  anchor.remove();
}
