part of '../absence_manager.dart';

class _BaseView extends StatelessWidget {
  final double width;
  const _BaseView({this.width = double.infinity});

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
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: CircleAvatar(radius: 30),
                  title: Text('Jawad Sheikh'),
                  subtitle: Text('Sick Leave'),
                  trailing: Container(
                    width: 70.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppTheme.kPrimary,
                    ),
                    child: Center(child: Text('Approved')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
