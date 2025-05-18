part of '../absence_manager.dart';

class _BaseView extends StatelessWidget {
  final double width;
  const _BaseView({this.width = double.infinity});

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
          Expanded(
            child: ListView(
              children:
                  [1, 2, 3, 4, 5, 6, 7, 5, 6, 7].map((e) {
                    return InkWell(
                      onTap: () {
                        bloc.add(AbsenceManagerTestEvent());
                      },
                      child: AbsenteeCard(),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
