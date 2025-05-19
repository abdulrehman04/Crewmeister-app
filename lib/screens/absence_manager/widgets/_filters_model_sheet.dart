part of '../absence_manager.dart';

class FiltersModalSheet extends StatelessWidget {
  const FiltersModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context);
    final bloc = Provider.of<AbsenceManagerBloc>(context);

    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          10.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filters",
                style: GoogleFonts.archivo(
                  fontWeight: FontWeight.w800,
                  fontSize: 35,
                ),
              ),
              GestureDetector(
                onTap: () {
                  screenState.resetFilters(bloc);
                  context.pop();
                },
                child: Text(
                  "Reset filters",
                  style: GoogleFonts.archivo(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          15.verticalSpace,
          AppDropdown(
            hint: 'Select leave type',
            value: screenState.filters.absenceType,
            items:
                AbsenceType.values.map((e) {
                  return DropdownMenuItem(value: e.label, child: Text(e.label));
                }).toList(),
            onChanged: (p0) {
              screenState.setLeaveTypeFilter(p0!);
            },
          ),
          10.verticalSpace,
          AppDropdown(
            hint: 'Select status',
            value: screenState.filters.status,
            items:
                ['Confirmed', 'Rejected', 'Requested'].map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
            onChanged: (p0) {
              screenState.setStatusFilter(p0!);
            },
          ),
          Spacer(),
          AppButton(
            label: 'Apply Filters',
            onPressed: () {
              screenState.fetchNewData(bloc);
              context.pop();
            },
            textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              // fontSize: 17.sp,
            ),
          ),
          10.verticalSpace,
        ],
      ),
    );
  }
}
