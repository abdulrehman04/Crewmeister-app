import 'package:crewmeister_app/configs/configs.dart';
import 'package:flutter/material.dart';

class AppDatePickerButton extends StatelessWidget {
  final String hint;
  final String? value;
  final DateTime firstDate, lastDate;
  final Function(DateTime? picked) onDatePick;
  const AppDatePickerButton({
    super.key,
    required this.hint,
    required this.firstDate,
    required this.lastDate,
    required this.onDatePick,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? date = await showDatePicker(
          context: context,
          firstDate: firstDate,
          lastDate: lastDate,
        );
        onDatePick(date);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppTheme.kBgColor,
          border: Border.all(
            color: AppTheme.kPrimary,
            width: value == null ? 0.2 : 0.9,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            value == null
                ? Text(
                  hint,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppTheme.ktextPrimary),
                )
                : Text(value!),
            Icon(
              Icons.expand_circle_down_outlined,
              color: AppTheme.ktextPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
