part of '../absence_manager.dart';

class _FiltersRow extends StatelessWidget {
  const _FiltersRow();

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
                return ChangeNotifierProvider.value(
                  value: screenState,
                  child: const FiltersModalSheet(),
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
