import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function()? onTapIcon;
  final IconData? prefixIcon;
  final IconData? sufffixIcon;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputformatters;

  const AppTextField({
    super.key,
    required this.controller,
    this.hintText = "Enter text",
    this.onChanged,
    this.onTapIcon,
    this.prefixIcon,
    this.sufffixIcon,
    this.validator,
    this.inputformatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon:
            controller.text.isNotEmpty
                ? IconButton(
                  icon: Icon(sufffixIcon ?? Icons.search),
                  onPressed: () {
                    controller.clear();
                    if (onTapIcon != null) onTapIcon!();
                  },
                )
                : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
      validator: validator,
      inputFormatters: inputformatters,
    );
  }
}
