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

  exportIcal(List<AbsenteeItem> absentees) async {
    CalendarService cal = CalendarService.instance;
    String calenderOutput = cal.generateICalContentForAbsences(
      absences: absentees,
    );

    File file = await cal.saveICalToFile(calenderOutput);
    OpenFile.open(file.path);
  }
}
