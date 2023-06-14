import 'package:flutter/material.dart';

class CustomExpandableBody extends StatefulWidget {
  const CustomExpandableBody({
    Key? key,
    required this.child,
    this.expand = false,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.fastOutSlowIn,
    this.axisAlignment = 0.0,
  }) : super(key: key);

  final Widget child;
  final bool expand;
  final Duration duration;
  final Curve curve;
  final double axisAlignment;

  @override
  State<CustomExpandableBody> createState() => _CustomExpandableBodyState();
}

class _CustomExpandableBodyState extends State<CustomExpandableBody>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  void prepareAnimations() {
    expandController =
        AnimationController(vsync: this, duration: widget.duration);
    animation = CurvedAnimation(
      parent: expandController,
      curve: widget.curve,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(CustomExpandableBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: widget.axisAlignment,
      axis: Axis.vertical,
      sizeFactor: animation,
      child: widget.child,
    );
  }
}