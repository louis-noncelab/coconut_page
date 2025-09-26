import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CoconutCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  final BoxShadow? shadow;
  final VoidCallback? onTap;

  const CoconutCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.shadow,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        boxShadow: shadow != null
            ? [shadow!]
            : elevation != null
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: elevation! * 2,
                      offset: Offset(0, elevation!),
                    ),
                  ]
                : null,
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );

    if (onTap != null) {
      card = InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: card,
      );
    }

    return card;
  }
}

class WalletCard extends CoconutCard {
  const WalletCard({
    super.key,
    required super.child,
    super.padding,
    super.margin,
    super.onTap,
  }) : super(
          backgroundColor: AppTheme.walletBg,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          shadow: const BoxShadow(
            color: Color(0x1A4CAF50),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        );
}

class VaultCard extends CoconutCard {
  const VaultCard({
    super.key,
    required super.child,
    super.padding,
    super.margin,
    super.onTap,
  }) : super(
          backgroundColor: AppTheme.vaultSurface,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          shadow: const BoxShadow(
            color: Color(0x1A8D6E63),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        );
}

