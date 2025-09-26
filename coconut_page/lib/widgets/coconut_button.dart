import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum CoconutButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  wallet,
  vault,
}

class CoconutButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final CoconutButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const CoconutButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = CoconutButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget buttonChild = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                _getTextColor(theme),
              ),
            ),
          )
        else if (icon != null)
          Icon(
            icon,
            size: 20,
            color: _getTextColor(theme),
          ),
        if ((isLoading || icon != null) && text.isNotEmpty)
          const SizedBox(width: 8),
        if (text.isNotEmpty)
          Text(
            text,
            style: TextStyle(
              color: _getTextColor(theme),
              fontWeight: FontWeight.w600,
              fontSize: 8,
            ),
          ),
      ],
    );

    if (width != null || height != null) {
      buttonChild = SizedBox(
        width: width,
        height: height,
        child: buttonChild,
      );
    }

    switch (variant) {
      case CoconutButtonVariant.primary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.coconutGreen,
            foregroundColor: Colors.white,
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: buttonChild,
        );

      case CoconutButtonVariant.secondary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.coconutBrown,
            foregroundColor: Colors.white,
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: buttonChild,
        );

      case CoconutButtonVariant.outline:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppTheme.coconutGreen,
            side: const BorderSide(color: AppTheme.coconutGreen),
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: buttonChild,
        );

      case CoconutButtonVariant.ghost:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppTheme.coconutGreen,
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: buttonChild,
        );

      case CoconutButtonVariant.wallet:
        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.coconutGreen, Color(0xFF45A049)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppTheme.coconutGreen.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              shadowColor: Colors.transparent,
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: buttonChild,
          ),
        );

      case CoconutButtonVariant.vault:
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.coconutBrown,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppTheme.coconutBrown.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              shadowColor: Colors.transparent,
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: buttonChild,
          ),
        );
    }
  }

  Color _getTextColor(ThemeData theme) {
    switch (variant) {
      case CoconutButtonVariant.primary:
      case CoconutButtonVariant.secondary:
      case CoconutButtonVariant.wallet:
      case CoconutButtonVariant.vault:
        return Colors.white;
      case CoconutButtonVariant.outline:
        return AppTheme.coconutGreen;
      case CoconutButtonVariant.ghost:
        return AppTheme.coconutGreen;
    }
  }
}
