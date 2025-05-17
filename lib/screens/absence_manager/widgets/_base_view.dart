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
        ],
      ),
    );
  }
}
