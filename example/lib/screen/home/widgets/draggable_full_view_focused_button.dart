import 'package:example/common/widgets/custom_icon_button.dart';
import 'package:example/gen/assets.gen.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:example/theme/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DraggableFullViewFocusedButton extends StatefulWidget {
  const DraggableFullViewFocusedButton({
    Key? key,
    required this.isAppBarCollapsed,
    required this.onPressed,
    required this.constraints,
  }) : super(key: key);

  final bool isAppBarCollapsed;
  final VoidCallback onPressed;
  final BoxConstraints constraints;

  @override
  State<DraggableFullViewFocusedButton> createState() =>
      _DraggableFullViewFocusedButtonState();
}

class _DraggableFullViewFocusedButtonState
    extends State<DraggableFullViewFocusedButton>
    with TickerProviderStateMixin {
  static const _kButtonSize = 32.0,
      _kButtonPadding = 20.0,
      _kMaxVelocityThreshold = 1500.00;

  late AnimationController _fadeOutController, _dragEndController;
  late Animation<double> _fadeOutAnimation;

  Animation<Offset>? _positionAnimation;

  @override
  void initState() {
    super.initState();

    _fadeOutController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _fadeOutController,
        curve: Curves.easeInOut,
      ),
    );

    _fadeOutController.forward();

    _dragEndController = AnimationController(vsync: this);
  }

  void _driveAnimation(BoxConstraints constraints, DraggableDetails details) {
    Size containerSize = Size(constraints.maxWidth, constraints.maxHeight);

    double xVelocity = details.velocity.pixelsPerSecond.dx;
    final unitsPerSecondX = xVelocity / containerSize.width;
    final dx =
        _calculateDeltaX(details.offset.dx, xVelocity, containerSize.width);

    double yVelocity = details.velocity.pixelsPerSecond.dy;
    final unitsPerSecondY = yVelocity / containerSize.height;
    final dy =
        _calculateDeltaY(details.offset.dy, yVelocity, containerSize.height);

    /// Calculate the velocity relative to the unit interval, [0,1],
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, unitVelocity);

    _positionAnimation = _dragEndController.drive(
      Tween<Offset>(
        /// begin from the place where the user released the finger
        begin: Offset(
          details.offset.dx,
          details.offset.dy - _kButtonSize,
        ),
        end: Offset(dx, dy),
      ),
    );
    _dragEndController.animateWith(simulation);
  }

  double _calculateDeltaX(double dragDx, double xVelocity, double screenWidth) {
    double dx = dragDx + (xVelocity * 0.1);

    bool hitLeftEdge = dx <= 0 + _kButtonSize,
        passedVelocityThresholdToTheLeft =
            (xVelocity < 0 && xVelocity.abs() > _kMaxVelocityThreshold),
        hitRightEdge = dx >= screenWidth - _kButtonSize,
        passedVelocityThresholdToTheRight =
            (xVelocity > 0 && xVelocity.abs() > _kMaxVelocityThreshold);

    if (hitLeftEdge || passedVelocityThresholdToTheLeft) {
      /// if hit the left edge of the screen or the velocity is too high
      /// then stuck the button to the left edge
      return _kButtonPadding;
    } else if (hitRightEdge || passedVelocityThresholdToTheRight) {
      /// if hit the right edge of the screen or the velocity is too high
      /// then stuck the button to the right edge
      return screenWidth - _kButtonPadding - _kButtonSize;
    }

    return dx;
  }

  double _calculateDeltaY(
      double dragDy, double yVelocity, double screenHeight) {
    double dy = dragDy - _kButtonSize + (yVelocity * 0.1);

    bool hitTopEdge = dy <= 0 + _kButtonSize,
        passedVelocityThresholdToTheTop =
            (yVelocity < 0 && yVelocity.abs() > _kMaxVelocityThreshold),
        hitBottomEdge = dy >= screenHeight - _kButtonSize,
        passedVelocityThresholdToTheBottom =
            (yVelocity > 0 && yVelocity.abs() > _kMaxVelocityThreshold);
    if (hitTopEdge || passedVelocityThresholdToTheTop) {
      /// if hit the top edge of the screen or the velocity is too high
      /// then stuck the button to the top edge
      return _kButtonPadding;
    } else if (hitBottomEdge || passedVelocityThresholdToTheBottom) {
      /// if hit the bottom edge of the screen or the velocity is too high
      /// then stuck the button to the bottom edge
      return screenHeight - _kButtonSize - _kButtonPadding;
    }

    return dy;
  }

  @override
  void dispose() {
    _fadeOutController.dispose();
    _dragEndController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _dragEndController,
      builder: (context, _) {
        return Positioned(
          left: _positionAnimation?.value.dx ??
              widget.constraints.maxWidth - _kButtonPadding - _kButtonSize,
          top: _positionAnimation?.value.dy ?? 20,
          child: Draggable(
            onDragEnd: (details) =>
                _driveAnimation(widget.constraints, details),
            childWhenDragging: const SizedBox.shrink(),
            feedback: _buildButton(context),
            child: _buildButton(context),
          ),
        );
      },
    );
  }

  Widget _buildButton(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: -30,
          child: FadeTransition(
            opacity: _fadeOutAnimation,
            child: SvgPicture.asset(
              Assets.icons.arrowMoveLeft.path,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -30,
          child: FadeTransition(
            opacity: _fadeOutAnimation,
            child: SvgPicture.asset(
              Assets.icons.arrowMoveDown.path,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        CustomIconButton.selectable(
          isSelected: widget.isAppBarCollapsed,
          icon: Assets.icons.fullView.path,
          selectedIcon: context.assets.fullViewFocusedIcon.path,
          followForegroundIconThemeColor: false,
          onPressed: widget.onPressed,
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: ColorName.darkGunmetal.withOpacity(.45),
              offset: const Offset(0, 3),
            )
          ],
        ),
      ],
    );
  }
}
