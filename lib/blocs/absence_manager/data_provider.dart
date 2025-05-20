part of './bloc.dart';

class _AbsenceManagerDataProvider {
  // A SINGLETON TO SAVE RE-READS OF DATA
  static final _AbsenceManagerDataProvider instance =
      _AbsenceManagerDataProvider._();

  _AbsenceManagerDataProvider._() {
    _apiService = ApiService.instance;
    if (!readInitialData) _readInitialData();
  }

  late ApiService _apiService;

  Future fetchAbsences({
    String? query,
    String? absenceType,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    required int page,
    required int pageSize,
    bool fetchFromLocal = false,
  }) async {
    if (fetchFromLocal) {
      return _fetchAbsencesFromLocal(
        query: query,
        absenceType: absenceType,
        startDate: startDate,
        endDate: endDate,
        status: status,
        page: page,
        pageSize: pageSize,
      );
    }
    String response = await _apiService.get(
      'absences',
      queryParams: {
        'query': query,
        'type': absenceType,
        'status': status,
        'page': page.toString(),
        'pageSize': pageSize.toString(),
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
      },
    );

    Map data = jsonDecode(response);
    return data;
  }

  Future exportAbsences({
    String? query,
    String? absenceType,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    bool fetchFromLocal = false,
  }) async {
    if (fetchFromLocal) {
      return _exportAbsencesFromLocal(
        query: query,
        absenceType: absenceType,
        startDate: startDate,
        endDate: endDate,
        status: query,
      );
    }
    String response = await _apiService.get(
      'export_absences',
      queryParams: {
        'query': query,
        'type': absenceType,
        'status': status,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
      },
    );

    Map data = jsonDecode(response);
    return data;
  }

  /// LOCAL SERVER IMPLEMENTATION
  List members = [];
  List absences = [];
  List<AbsenteeItem> absenceItems = [];

  bool readInitialData = false;

  Future<void> _readInitialData() async {
    readInitialData = true;
    API api = API();
    List absencesData = await api.absences();
    List membersData = await api.members();

    absences = absencesData.map((item) => Absence.fromJson(item)).toList();
    members = membersData.map((item) => Member.fromJson(item)).toList();

    for (var absence in absences) {
      final member = members.firstWhere((m) => m.userId == absence.userId);

      absenceItems.add(
        AbsenteeItem.fromAbsenceAndMember(absence: absence, member: member),
      );
    }
  }

  Future<PaginatedAbsenceResult> _fetchAbsencesFromLocal({
    String? query,
    String? absenceType,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    required int page,
    required int pageSize,
  }) async {
    if (!readInitialData) {
      await _readInitialData();
    }

    List<AbsenteeItem> filtered = absenceItems;
    // Name filter
    if (query != null && query.trim().isNotEmpty) {
      filtered =
          filtered
              .where(
                (item) =>
                    item.memberName.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }

    // Absence type filter
    if (absenceType != null) {
      filtered =
          filtered.where((item) {
            return item.type == absenceType;
          }).toList();
    }

    // Date filters
    if (startDate != null && endDate != null) {
      // overlapping dates
      filtered =
          filtered
              .where(
                (item) =>
                    item.endDate.isAfter(
                      startDate.subtract(const Duration(days: 1)),
                    ) &&
                    item.startDate.isBefore(
                      endDate.add(const Duration(days: 1)),
                    ),
              )
              .toList();
    } else if (startDate != null) {
      filtered =
          filtered
              .where(
                (item) => item.endDate.isAfter(
                  startDate.subtract(const Duration(days: 1)),
                ),
              )
              .toList();
    } else if (endDate != null) {
      filtered =
          filtered
              .where(
                (item) => item.startDate.isBefore(
                  endDate.add(const Duration(days: 1)),
                ),
              )
              .toList();
    }

    // Status filter
    if (status != null) {
      filtered = filtered.where((item) => item.status == status).toList();
    }

    // Pagination
    final startIndex = (page - 1) * pageSize;
    final endIndex = startIndex + pageSize;
    final totalResults = filtered.length;

    if (startIndex >= filtered.length) {
      return PaginatedAbsenceResult(
        absences: [],
        hasMore: false,
        totalResults: totalResults,
      );
    }

    final hasMore = filtered.length > endIndex;

    final result = filtered.sublist(
      startIndex,
      endIndex > filtered.length ? filtered.length : endIndex,
    );

    return PaginatedAbsenceResult(
      absences: result,
      hasMore: hasMore,
      totalResults: totalResults,
    );
  }

  Future<List<AbsenteeItem>> _exportAbsencesFromLocal({
    String? query,
    String? absenceType,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
  }) async {
    if (!readInitialData) {
      await _readInitialData();
    }

    List<AbsenteeItem> filtered = absenceItems;
    // Name filter
    if (query != null && query.trim().isNotEmpty) {
      filtered =
          filtered
              .where(
                (item) =>
                    item.memberName.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }

    // Absence type filter
    if (absenceType != null) {
      filtered =
          filtered.where((item) {
            return item.type == absenceType;
          }).toList();
    }

    // Date filters
    if (startDate != null && endDate != null) {
      // overlapping dates
      filtered =
          filtered
              .where(
                (item) =>
                    item.endDate.isAfter(
                      startDate.subtract(const Duration(days: 1)),
                    ) &&
                    item.startDate.isBefore(
                      endDate.add(const Duration(days: 1)),
                    ),
              )
              .toList();
    } else if (startDate != null) {
      filtered =
          filtered
              .where(
                (item) => item.endDate.isAfter(
                  startDate.subtract(const Duration(days: 1)),
                ),
              )
              .toList();
    } else if (endDate != null) {
      filtered =
          filtered
              .where(
                (item) => item.startDate.isBefore(
                  endDate.add(const Duration(days: 1)),
                ),
              )
              .toList();
    }

    // Status filter
    if (status != null) {
      filtered = filtered.where((item) => item.status == status).toList();
    }

    return filtered;
  }
}
