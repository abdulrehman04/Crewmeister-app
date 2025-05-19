part of '../absence_manager.dart';

class _BuildContent extends StatelessWidget {
  const _BuildContent({required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    _ScreenState screenState = _ScreenState.s(context);
    final bloc = Provider.of<AbsenceManagerBloc>(context);

    return BlocConsumer<AbsenceManagerBloc, AbsenceManagerState>(
      listenWhen: (previous, current) {
        if (previous.exportAbsencesState is ExportAbsencesSuccessState &&
            current.exportAbsencesState is ExportAbsencesSuccessState) {
          return false;
        }
        return true;
      },
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
                child: _BuildList(
                  absences: absences,
                  hasMore: hasMore,
                  scrollController: scrollController,
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
