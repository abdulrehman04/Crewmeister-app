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

    return Form(
      key: screenState.formKey,
      child: Column(
        children: [
          _SearchView(),
          10.verticalSpace,
          FiltersRow(),
          15.verticalSpace,
          AppHeading(heading: "Absentees"),
          Expanded(child: _BuildList(scrollController: _scrollController)),
        ],
      ),
    );
  }
}
