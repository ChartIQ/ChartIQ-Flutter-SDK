import 'package:flutter/material.dart';

class CustomFadeInContainer extends StatefulWidget {
  const CustomFadeInContainer({
    Key? key,
    required this.child,
    this.customDuration,
  })  : isSliver = false,
        super(key: key);

  const CustomFadeInContainer.sliver({
    Key? key,
    required this.child,
    this.customDuration,
  })  : isSliver = true,
        super(key: key);

  final Widget child;
  final Duration? customDuration;
  final bool isSliver;

  @override
  State<CustomFadeInContainer> createState() => _CustomFadeInContainerState();
}

class _CustomFadeInContainerState extends State<CustomFadeInContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: widget.customDuration ?? const Duration(milliseconds: 500),
    );

    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isSliver) {
      return SliverFadeTransition(
          opacity: _fadeInFadeOut, sliver: widget.child);
    }
    return FadeTransition(opacity: _fadeInFadeOut, child: widget.child);
  }
}
