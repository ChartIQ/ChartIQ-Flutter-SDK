import 'package:flutter/material.dart';

class FloatingModal extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const FloatingModal({
    Key? key,
    required this.child,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 900,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
          ClipRRect(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 100,
                horizontal: 60,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
