part of './absence_manager.dart';

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  TextEditingController searchController = TextEditingController();
  AbsenceFilters filters = AbsenceFilters();

  final formKey = GlobalKey<FormState>();

  int page = 1;
  Timer? debounce;

  void incrementPage() {
    page++;
    notifyListeners();
  }

  void resetFilters(AbsenceManagerBloc bloc) {
    filters = AbsenceFilters();
    searchController.text = '';

    fetchNewData(bloc);
  }

  void addSearchFilter(String input) {
    filters = filters.copyWith(query: input);
  }

  void addStartDateFilter(DateTime? date) {
    if (date == null) return;
    filters = filters.copyWith(startDate: date);
  }

  void addEndDateFilter(DateTime? date) {
    if (date == null) return;
    filters = filters.copyWith(endDate: date);
  }

  void setLeaveTypeFilter(String leaveType) {
    filters = filters.copyWith(absenceType: leaveType);
  }

  void setStatusFilter(String status) {
    filters = filters.copyWith(status: status);
  }

  void fetchNewData(AbsenceManagerBloc bloc) {
    bloc.add(FetchAbsencesEvent(pageSize: 10, filters: filters));
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Color(0xffD1FADF);
      case 'rejected':
        return Color(0xffFEE4E2);
      default:
        return AppTheme.kSecondary;
    }
  }

  Color getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Color(0xff027A48);
      case 'rejected':
        return Color(0xffB42318);
      default:
        return AppTheme.kPrimary;
    }
  }

  exportIcal(List<AbsenteeItem> absentees) async {
    CalendarService cal = CalendarService.instance;
    String content = cal.generateICalContentForAbsences(absences: absentees);

    if (kIsWeb) {
      downloadICalFile(content);
    } else {
      File file = await cal.saveICalToFile(content);
      OpenFile.open(file.path);
    }
  }
}
