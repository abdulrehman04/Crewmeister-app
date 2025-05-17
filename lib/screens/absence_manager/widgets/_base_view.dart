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
              children:
                  [1, 2, 3, 4, 5, 6, 7, 5, 6, 7].map((e) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppTheme.kWhite,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            color: const Color(
                              0xff000000,
                            ).withSafeOpacity(0.25),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(
                        left: 2,
                        right: 2,
                        bottom: 15,
                        top: 2,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(radius: 30),
                                  13.horizontalSpace,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Jawad Sheikh',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyLarge,
                                      ),
                                      Text(
                                        'Sick Leave',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.grey[800]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                width: 80.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppTheme.kPrimary,
                                  border: Border.all(
                                    width: 2,
                                    color: AppTheme.kPrimary,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Approved',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: AppTheme.kWhite),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          15.verticalSpace,
                          NoteWidget(
                            title: 'Member note',
                            note: 'This is a long sample note',
                          ),
                          10.verticalSpace,
                          NoteWidget(
                            title: 'Member note',
                            note: 'This is a long sample note',
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
