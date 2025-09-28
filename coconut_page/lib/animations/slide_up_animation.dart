import 'package:flutter/material.dart';

class SlideUpAnimation extends StatefulWidget {
  const SlideUpAnimation({
    super.key,
    required this.child,
    this.delay = Duration.zero, // 지연 시간 추가
  });

  final Widget child;
  final Duration delay;

  @override
  State<SlideUpAnimation> createState() => _SlideUpAnimationState();
}

class _SlideUpAnimationState extends State<SlideUpAnimation> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();

    // 애니메이션 컨트롤러 초기화
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // 페이드인 애니메이션
    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    // 슬라이드업 애니메이션
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5), // 아래에서 시작
      end: Offset.zero, // 원래 위치
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
    ));

    // 지연 후 애니메이션 시작
    Future.delayed(widget.delay, () {
      if (mounted) {
        animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: widget.child, // child 대신 widget.child 사용
          ),
        );
      },
    );
  }
}
