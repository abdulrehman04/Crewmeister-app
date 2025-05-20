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
  int _gridCount(double screenWidth) {
    const minTileWidth = 380.0;
    final count = (screenWidth / minTileWidth).floor();
    return count < 1 ? 1 : count;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final gridCount = _gridCount(screenWidth);
    final itemCount = widget.absences.length + (widget.hasMore ? 1 : 0);

    return MasonryGridView.builder(
      key: const PageStorageKey('AbsenteeGrid'),
      controller: widget.scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridCount > 3 ? 3 : gridCount,
      ),
      itemBuilder: (context, index) {
        if (index == widget.absences.length && widget.hasMore) {
          return const Center(child: CircularProgressIndicator());
        }

        final item = widget.absences[index];
        return AbsenteeCard(
          shouldUseFixedSize: gridCount > 1,
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
