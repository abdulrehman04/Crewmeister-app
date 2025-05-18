part of '../absence_manager.dart';

class FiltersRow extends StatelessWidget {
  const FiltersRow({super.key});

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context);
    final bloc = Provider.of<AbsenceManagerBloc>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: AppDatePickerButton(
            hint: 'Start Date',
            value:
                screenState.filters.startDate != null
                    ? DateFormat.yMMMd().format(screenState.filters.startDate!)
                    : null,
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
            onDatePick: (date) {
              screenState.addStartDateFilter(date);
              screenState.fetchNewData(bloc);
            },
          ),
        ),
        5.horizontalSpace,
        Expanded(
          child: AppDatePickerButton(
            hint: 'End Date',
            value:
                screenState.filters.endDate != null
                    ? DateFormat.yMMMd().format(screenState.filters.endDate!)
                    : null,
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
            onDatePick: (date) {
              screenState.addEndDateFilter(date);
              screenState.fetchNewData(bloc);
            },
          ),
        ),
        5.horizontalSpace,
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      10.verticalSpace,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Filters",
                          style: GoogleFonts.archivo(
                            fontWeight: FontWeight.w800,
                            fontSize: 35,
                          ),
                        ),
                      ),
                      15.verticalSpace,
                      AppDropdown(
                        hint: 'Select leave type',
                        items:
                            [1, 2, 3, 4, 5].map((e) {
                              return DropdownMenuItem(
                                child: Text('$e'),
                                value: e,
                              );
                            }).toList(),
                        onChanged: (p0) {},
                      ),
                      10.verticalSpace,
                      AppDropdown(
                        hint: 'Select status',
                        items:
                            [1, 2, 3, 4, 5].map((e) {
                              return DropdownMenuItem(
                                child: Text('$e'),
                                value: e,
                              );
                            }).toList(),
                        onChanged: (p0) {},
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.kWhite,
              boxShadow: [boxShad(0, 0, 5)],
            ),
            padding: EdgeInsets.all(8),
            child: Icon(Icons.filter_list_sharp, size: 30),
          ),
        ),
      ],
    );
  }
}
