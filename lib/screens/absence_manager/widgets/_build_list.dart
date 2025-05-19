part of '../absence_manager.dart';

class _BuildList extends StatefulWidget {
  const _BuildList({
    required this.absences,
    required this.hasMore,
    required this.scrollController,
    super.key,
  });

  final List<AbsenteeItem> absences;
  final bool hasMore;
  final ScrollController scrollController;

  @override
  State<_BuildList> createState() => __BuildListState();
}

class __BuildListState extends State<_BuildList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const PageStorageKey('AbsenteeList'),
      controller: widget.scrollController,
      itemCount: widget.absences.length + (widget.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == widget.absences.length && widget.hasMore) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final item = widget.absences[index];
        return AbsenteeCard(
          name: item.memberName,
          status: item.status,
          startDate: DateFormat.yMMMd().format(item.startDate),
          endDate: DateFormat.yMMMd().format(item.endDate),
          leaveType: item.type,
          memberNote: item.memberNote,
          admitterNote: item.admitterNote,
          userImg: item.memberImage,
        );
      },
    );
  }
}
