part of '../absence_manager.dart';

class _BaseView extends StatefulWidget {
  final double width;
  const _BaseView({this.width = double.infinity});

  @override
  State<_BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<_BaseView> {
  @override
  void initState() {
    super.initState();
    final bloc = Provider.of<AbsenceManagerBloc>(context, listen: false);
    bloc.add(FetchAbsencesEvent(page: 1, pageSize: 10));
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
            children: [
              Expanded(
                child: AppDropdown(
                  hint: "Select Item",
                  items:
                      [1, 2, 3, 4, 5].map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        );
                      }).toList(),
                  onChanged: (p0) {},
                ),
              ),
              5.horizontalSpace,
              Expanded(
                child: AppDropdown(
                  hint: "Select Item",
                  items:
                      [1, 2, 3, 4, 5].map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
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
                if (state.fetchAbsenteesState.absences.isEmpty) {
                  return const Center(child: Text("No Absentees"));
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.fetchAbsenteesState.absences.length,
                    itemBuilder: (context, index) {
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
