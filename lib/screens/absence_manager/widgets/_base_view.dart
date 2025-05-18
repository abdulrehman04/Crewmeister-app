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
    bloc.add(FetchAbsencesEvent(pageSize: 10, filters: AbsenceFilters()));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final screenState = _ScreenState.s(context);
      context.read<AbsenceManagerBloc>().add(
        FetchAbsencesEvent(pageSize: 10, filters: screenState.filters),
      );
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
    final bloc = Provider.of<AbsenceManagerBloc>(context);

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
            onChanged: (p0) {
              if (screenState.debounce?.isActive ?? false) {
                screenState.debounce!.cancel();
              }
              screenState.debounce = Timer(
                const Duration(milliseconds: 500),
                () {
                  screenState.addSearchFilter(p0);
                  bloc.add(
                    FetchAbsencesEvent(
                      filters: screenState.filters,
                      pageSize: 10,
                    ),
                  );
                },
              );
            },
          ),
          10.verticalSpace,
          FiltersRow(),
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
                      AbsenteeItem item = absences[index];
                      return AbsenteeCard(
                        name: item.memberName,
                        status: item.status,
                        startDate: DateFormat.yMMMd().format(item.startDate),
                        endDate: DateFormat.yMMMd().format(item.endDate),
                        leaveType: item.type,
                        memberNote: item.memberNote,
                        admitterNote: item.admitterNote,
                      );
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
