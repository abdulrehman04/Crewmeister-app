part of '../absence_manager.dart';

class _BuildContent extends StatelessWidget {
  const _BuildContent({required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    _ScreenState screenState = _ScreenState.s(context);
    final bloc = Provider.of<AbsenceManagerBloc>(context);

    return BlocConsumer<AbsenceManagerBloc, AbsenceManagerState>(
      listener: (context, state) {
        if (state.exportAbsencesState is ExportAbsencesSuccessState) {
          screenState.exportIcal(state.exportAbsencesState.absences);
        }
      },
      builder: (context, state) {
        if (state.fetchAbsenteesState is FetchAbsencesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.fetchAbsenteesState is FetchAbsencesFailureState) {
          return Center(
            child: Text(state.fetchAbsenteesState.message ?? "Error"),
          );
        }
        if (state.fetchAbsenteesState is FetchAbsencesSuccessState) {
          final success =
              state.fetchAbsenteesState as FetchAbsencesSuccessState;

          final absences = success.absences;
          final hasMore = success.hasMore;
          final total = success.totalResults;

          if (state.fetchAbsenteesState.absences.isEmpty) {
            return const Center(child: Text("No Absentees"));
          }
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Showing ${absences.length}/$total results'),
                  InkWell(
                    onTap: () {
                      bloc.add(
                        ExportAbsencesEvent(filters: screenState.filters),
                      );
                    },
                    child: Text(
                      'Export results',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              15.verticalSpace,
              Expanded(
                //   child: _BuildList(
                //     absences: absences,
                //     hasMore: hasMore,
                //     scrollController: scrollController,
                //     key: const PageStorageKey('BuildList'),
                //   ),
                child: ListView.builder(
                  key: PageStorageKey('AbsenteeList'),
                  controller: scrollController,
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
                      userImg: item.memberImage,
                    );
                  },
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
