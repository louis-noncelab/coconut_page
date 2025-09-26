import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CoconutBadge extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  const CoconutBadge({
    super.key,
    required this.text,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: 1)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 14,
              color: textColor ?? AppTheme.textSecondary,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor ?? AppTheme.textSecondary,
              fontSize: 6,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class OutlineBadge extends CoconutBadge {
  const OutlineBadge({
    super.key,
    required super.text,
    super.icon,
    Color? color,
  }) : super(
          borderColor: color ?? AppTheme.coconutGreen,
          textColor: color ?? AppTheme.coconutGreen,
        );
}

class GreenBadge extends CoconutBadge {
  const GreenBadge({
    super.key,
    required super.text,
    super.icon,
  }) : super(
          backgroundColor: AppTheme.coconutGreen,
          textColor: Colors.white,
        );
}

class BrownBadge extends CoconutBadge {
  const BrownBadge({
    super.key,
    required super.text,
    super.icon,
  }) : super(
          backgroundColor: AppTheme.coconutBrown,
          textColor: Colors.white,
        );
}
