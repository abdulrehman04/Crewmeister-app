import 'dart:convert';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:intl/intl.dart';

import '../models/absence_model.dart';
import '../models/absentee_item.dart';
import '../models/member_model.dart';

List<AbsenteeItem> absenceItems = [];

// Called once to read and parse
Future<void> ensureDataLoaded() async {
  var absences = <Absence>[];
  var members = <Member>[];

  if (absenceItems.isEmpty) {
    final aStr = jsonDecode(await File('data/absences.json').readAsString())
        as Map<String, dynamic>;
    final mStr = jsonDecode(await File('data/members.json').readAsString())
        as Map<String, dynamic>;

    absences = (aStr['payload'] as List)
        .map((item) => Absence.fromJson(item as Map<String, dynamic>))
        .toList();

    members = (mStr['payload'] as List)
        .map((item) => Member.fromJson(item as Map<String, dynamic>))
        .toList();

    for (final absence in absences) {
      final member = members.firstWhere((m) => m.userId == absence.userId);

      absenceItems.add(
        AbsenteeItem.fromAbsenceAndMember(absence: absence, member: member),
      );
    }
  }
}

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
  final page = int.tryParse(query['page'] ?? '1') ?? 1;
  final pageSize = int.tryParse(query['pageSize'] ?? '10') ?? 10;

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

  // Pagination
  final startIndex = (page - 1) * pageSize;
  final endIndex = startIndex + pageSize;
  final totalResults = filtered.length;

  if (startIndex >= filtered.length) {
    return Response.json(
      body: {
        'payload': <Map<String, dynamic>>[],
        'totalResults': totalResults,
        'hasMore': false,
      },
    );
  }

  final hasMore = filtered.length > endIndex;

  final result = filtered.sublist(
    startIndex,
    endIndex > filtered.length ? filtered.length : endIndex,
  );

  return Response.json(
    body: {
      'payload': result.map((e) => e.toMap()).toList(),
      'totalResults': totalResults,
      'hasMore': hasMore,
    },
  );
}

String getStatus(Map<String, dynamic> absence) {
  if (absence['rejectedAt'] != null) return 'Rejected';
  if (absence['confirmedAt'] != null) return 'Confirmed';
  return 'Requested';
}
