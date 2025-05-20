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

    // Allowing for local data repo to read data
    Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        bloc.add(FetchAbsencesEvent(pageSize: 10, filters: AbsenceFilters()));
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final screenState = _ScreenState.s(context);
      final bloc = Provider.of<AbsenceManagerBloc>(context, listen: false);

      if (bloc.state.fetchAbsenteesState.hasMore) {
        if (screenState.debounce?.isActive ?? false) {
          screenState.debounce?.cancel();
        }

        screenState.debounce = Timer(const Duration(milliseconds: 300), () {
          if (mounted) {
            bloc.add(
              FetchAbsencesEvent(pageSize: 10, filters: screenState.filters),
            );
          }
        });
      }
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

    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: widget.width,
        child: Form(
          key: screenState.formKey,
          child: Column(
            children: [
              _SearchView(),
              10.verticalSpace,
              _FiltersRow(),
              15.verticalSpace,
              AppHeading(heading: "Absentees"),
              Expanded(
                child: _BuildContent(scrollController: _scrollController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
