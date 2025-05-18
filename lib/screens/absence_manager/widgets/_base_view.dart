part of '../absence_manager.dart';

class _BaseView extends StatefulWidget {
  final double width;
  const _BaseView({this.width = double.infinity});

  @override
  State<_BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<_BaseView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    final bloc = Provider.of<AbsenceManagerBloc>(context, listen: false);
    bloc.add(FetchAbsencesEvent(pageSize: 10));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<AbsenceManagerBloc>().add(FetchAbsencesEvent(pageSize: 10));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context);

    return Form(
      key: screenState.formKey,
      child: Column(
        children: [
          AppTextField(
            hintText: "Search User",
            controller: screenState.searchController,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.alphabetical(),
            ]),
            sufffixIcon: Icons.search,
          ),
          10.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AppDatePickerButton(
                  hint: 'Start Date',
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                  onDatePick: (date) {},
                ),
              ),
              5.horizontalSpace,
              Expanded(
                child: AppDatePickerButton(
                  hint: 'End Date',
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                  onDatePick: (date) {},
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
          ),
          15.verticalSpace,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Absentees",
              style: GoogleFonts.archivo(
                fontWeight: FontWeight.w800,
                fontSize: 40,
              ),
            ),
          ),
          10.verticalSpace,
          BlocBuilder<AbsenceManagerBloc, AbsenceManagerState>(
            builder: (context, state) {
              if (state.fetchAbsenteesState is FetchAbsencesLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.fetchAbsenteesState
                  is FetchAbsencesFailureState) {
                return Center(
                  child: Text(state.fetchAbsenteesState.message ?? "Error"),
                );
              }
              if (state.fetchAbsenteesState is FetchAbsencesSuccessState) {
                final absences = state.fetchAbsenteesState.absences;
                final hasMore = state.fetchAbsenteesState.hasMore;

                if (state.fetchAbsenteesState.absences.isEmpty) {
                  return const Center(child: Text("No Absentees"));
                }
                return Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: absences.length + (hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == absences.length && hasMore) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      return AbsenteeCard();
                    },
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
