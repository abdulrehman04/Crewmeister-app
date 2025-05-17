part of '../absence_manager.dart';

class AbsenteeCard extends StatelessWidget {
  const AbsenteeCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                  CircleAvatar(radius: 30),
                  13.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jawad Sheikh',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        'Sick Leave',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 85.w,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppTheme.kPrimary,
                  border: Border.all(width: 2, color: AppTheme.kPrimary),
                ),
                child: Center(
                  child: Text(
                    'Approved',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppTheme.kWhite),
                  ),
                ),
              ),
            ],
          ),
          15.verticalSpace,
          NoteWidget(title: 'Member note', note: 'This is a long sample note'),
          10.verticalSpace,
          NoteWidget(
            title: 'Admitter note',
            note: 'This is a long sample note',
          ),
          15.verticalSpace,
          // DATE PILL
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xffFFF2E0),
                border: Border.all(color: Color(0xffFFE0B3)),
              ),
              child: Text(
                '24 MAY, 2025 - 26 MAY, 2025',
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
