import 'package:crewmeister_app/configs/configs.dart';
import 'package:flutter/material.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.hint,
    required this.items,
    this.isSquared = false,
    this.validator,
    this.width,
    this.onChanged,
    this.hintColor = AppTheme.ktextSecondary,
  });
  final String hint;
  final List<DropdownMenuItem<T>> items;
  final double? width;
  final bool isSquared;
  final String? Function(T?)? validator;
  final Function(T?)? onChanged;
  final Color hintColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          icon: Icon(Icons.expand_circle_down_outlined),
          isExpanded: true,
          hint: Text(hint),
          decoration: InputDecoration(
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(isSquared ? 5 : 17),
              borderSide: BorderSide(color: AppTheme.kPrimary, width: 0.7),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(isSquared ? 5 : 17),
              borderSide: BorderSide(color: AppTheme.kPrimary, width: 0.1),
            ),
            contentPadding: EdgeInsets.all(15),
          ),
          items: items,
          onChanged: onChanged,
          validator: validator,
        ),
      ),
    );
  }
}
