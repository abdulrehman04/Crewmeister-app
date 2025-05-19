part of '../absence_manager.dart';

class AbsenteeCard extends StatelessWidget {
  final String name, leaveType, status, startDate, endDate;
  final String? admitterNote, memberNote, userImg;
  const AbsenteeCard({
    super.key,
    this.admitterNote,
    required this.endDate,
    required this.leaveType,
    this.memberNote,
    required this.name,
    required this.startDate,
    required this.status,
    this.userImg,
  });

  @override
  Widget build(BuildContext context) {
    _ScreenState screenState = _ScreenState.s(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppTheme.kWhite,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: const Color(0xff000000).withSafeOpacity(0.25),
            blurRadius: 2,
          ),
        ],
      ),
      margin: EdgeInsets.only(left: 2, right: 2, bottom: 15, top: 2),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(userImg ?? ''),
                  ),
                  13.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: Theme.of(context).textTheme.bodyLarge),
                      Text(
                        leaveType,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.ktextPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 90.w,
                height: 35.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: screenState.getStatusColor(status),
                  border: Border.all(
                    width: 0.2,
                    color: screenState.getStatusTextColor(status),
                  ),
                ),
                child: Center(
                  child: Text(
                    status,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: screenState.getStatusTextColor(status),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (memberNote != '') 15.verticalSpace,
          if (memberNote != '')
            NoteWidget(title: 'Member note', note: memberNote ?? ''),
          if (admitterNote != '') 10.verticalSpace,
          if (admitterNote != '')
            NoteWidget(title: 'Admitter note', note: admitterNote ?? ''),
          15.verticalSpace,
          // DATE PILL
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppTheme.kSecondary,
                border: Border.all(color: AppTheme.kBorderColor),
              ),
              child: Text(
                '$startDate - $endDate',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.kPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
