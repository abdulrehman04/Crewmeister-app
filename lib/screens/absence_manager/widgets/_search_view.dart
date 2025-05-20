part of '../absence_manager.dart';

class _SearchView extends StatelessWidget {
  const _SearchView();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context);
    final bloc = Provider.of<AbsenceManagerBloc>(context);

    return AppTextField(
      hintText: "Search User",
      controller: screenState.searchController,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.alphabetical(),
      ]),
      inputformatters: [CustomInputFormatters.nameOnlyFormatter],
      sufffixIcon:
          screenState.searchController.text != '' ? Icons.clear : Icons.search,
      onTapIcon: () {
        screenState.addSearchFilter('');
        screenState.fetchNewData(bloc);
      },
      onChanged: (p0) {
        if (screenState.debounce?.isActive ?? false) {
          screenState.debounce!.cancel();
        }
        screenState.debounce = Timer(const Duration(milliseconds: 500), () {
          screenState.addSearchFilter(p0);
          screenState.fetchNewData(bloc);
        });
      },
    );
  }
}
