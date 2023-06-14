import 'package:flutter/material.dart';

class CustomScaleDownContainer extends StatefulWidget {
  const CustomScaleDownContainer({
    Key? key,
    required this.child,
    this.customDuration,
  }) : super(key: key);

  final Widget child;
  final Duration? customDuration;

  @override
  State<CustomScaleDownContainer> createState() =>
      _CustomScaleDownContainerState();
}

class _CustomScaleDownContainerState extends State<CustomScaleDownContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> _scaleDown;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: widget.customDuration ?? const Duration(milliseconds: 500),
    );

    _scaleDown = Tween<double>(begin: 1.2, end: 1.0).animate(
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
    return ScaleTransition(scale: _scaleDown, child: widget.child);
  }
}
