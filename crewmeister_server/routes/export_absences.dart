import 'package:dart_frog/dart_frog.dart';
import 'package:intl/intl.dart';

import 'absences.dart';

Future<Response> onRequest(RequestContext context) async {
  await ensureDataLoaded();

  final query = context.request.uri.queryParameters;
  final search = query['query']?.toLowerCase();
  final type = query['type'];
  final status = query['status'];
  final startDateStr = query['startDate'];
  DateTime? startDate;
  if (startDateStr != null && startDateStr.isNotEmpty) {
    startDate = DateFormat().parse(startDateStr);
  }
  final endDateStr = query['endDate'];
  DateTime? endDate;
  if (endDateStr != null && endDateStr.isNotEmpty) {
    endDate = DateFormat().parse(endDateStr);
  }

  var filtered = absenceItems;
  // Name filter
  if (search != null && search.trim().isNotEmpty) {
    filtered = filtered
        .where(
          (item) =>
              item.memberName.toLowerCase().contains(search.toLowerCase()),
        )
        .toList();
  }

  // Absence type filter
  if (type != null && type.isNotEmpty) {
    filtered = filtered.where((item) {
      return item.type == type;
    }).toList();
  }

  // Date filters
  if (startDate != null && endDate != null) {
    // overlapping dates
    filtered = filtered
        .where(
          (item) =>
              item.endDate.isAfter(
                startDate!.subtract(const Duration(days: 1)),
              ) &&
              item.startDate.isBefore(
                endDate!.add(const Duration(days: 1)),
              ),
        )
        .toList();
  } else if (startDate != null) {
    filtered = filtered
        .where(
          (item) => item.endDate.isAfter(
            startDate!.subtract(const Duration(days: 1)),
          ),
        )
        .toList();
  } else if (endDate != null) {
    filtered = filtered
        .where(
          (item) => item.startDate.isBefore(
            endDate!.add(const Duration(days: 1)),
          ),
        )
        .toList();
  }

  // Status filter
  if (status != null && status.isNotEmpty) {
    filtered = filtered.where((item) => item.status == status).toList();
  }

  return Response.json(
    body: {
      'payload': filtered.map((e) => e.toMap()).toList(),
    },
  );
}
