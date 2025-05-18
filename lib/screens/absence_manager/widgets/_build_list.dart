part of '../absence_manager.dart';

class _BuildList extends StatelessWidget {
  const _BuildList({required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceManagerBloc, AbsenceManagerState>(
      builder: (context, state) {
        if (state.fetchAbsenteesState is FetchAbsencesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.fetchAbsenteesState is FetchAbsencesFailureState) {
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
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
