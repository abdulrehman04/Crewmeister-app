import 'package:crewmeister_app/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final IconData? icon;
  final bool isSquared;
  const AppButton({
    required this.label,
    required this.onPressed,
    this.height,
    this.width,
    this.backgroundColor,
    this.textStyle,
    this.icon,
    this.isSquared = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width ?? double.infinity,
        height: height ?? 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isSquared ? 5 : 30),
          color: backgroundColor ?? AppTheme.kPrimary,
        ),
        child:
            icon != null
                ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon!, color: AppTheme.ktextPrimary),
                      20.horizontalSpace,
                      Text(
                        label,
                        style:
                            textStyle ??
                            textStyle ??
                            Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                )
                : Center(
                  child: Text(
                    label,
                    style:
                        textStyle ??
                        textStyle ??
                        Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
      ),
    );
  }
}
