import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.iconButtonBackgroundColor,
    required this.iconButtonSelectedBackgroundColor,
    required this.iconButtonSelectedForegroundColor,
    required this.mainAppBarColor,
    required this.modalAppBarUnderlineColor,
    required this.listTileTrailingIconColor,
    required this.drawingToolPanelPickerBackgroundColor,
    required this.segmentedControlBackgroundColor,
    required this.segmentedControlSelectedColor,
  });

  final Color? iconButtonBackgroundColor,
      iconButtonSelectedBackgroundColor,
      iconButtonSelectedForegroundColor,
      mainAppBarColor,
      modalAppBarUnderlineColor,
      listTileTrailingIconColor,
      drawingToolPanelPickerBackgroundColor,
      segmentedControlBackgroundColor,
      segmentedControlSelectedColor;

  @override
  AppColors copyWith({
    Color? iconButtonBackgroundColor,
    Color? iconButtonSelectedBackgroundColor,
    Color? iconButtonSelectedForegroundColor,
    Color? iconButtonForegroundColor,
    Color? mainAppBarColor,
    Color? modalAppBarUnderlineColor,
    Color? listTileTrailingIconColor,
    Color? drawingToolPanelPickerBackgroundColor,
    Color? segmentedControlBackgroundColor,
    Color? segmentedControlSelectedColor,
  }) {
    return AppColors(
      iconButtonBackgroundColor:
          iconButtonBackgroundColor ?? this.iconButtonBackgroundColor,
      iconButtonSelectedBackgroundColor: iconButtonSelectedBackgroundColor ??
          this.iconButtonSelectedBackgroundColor,
      iconButtonSelectedForegroundColor:
          iconButtonForegroundColor ?? this.iconButtonSelectedForegroundColor,
      mainAppBarColor: mainAppBarColor ?? this.mainAppBarColor,
      modalAppBarUnderlineColor:
          modalAppBarUnderlineColor ?? this.modalAppBarUnderlineColor,
      listTileTrailingIconColor:
          listTileTrailingIconColor ?? this.listTileTrailingIconColor,
      drawingToolPanelPickerBackgroundColor:
          drawingToolPanelPickerBackgroundColor ??
              this.drawingToolPanelPickerBackgroundColor,
      segmentedControlBackgroundColor: segmentedControlBackgroundColor ??
          this.segmentedControlBackgroundColor,
      segmentedControlSelectedColor:
          segmentedControlSelectedColor ?? this.segmentedControlSelectedColor,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      iconButtonBackgroundColor: Color.lerp(
        iconButtonBackgroundColor,
        other.iconButtonBackgroundColor,
        t,
      ),
      iconButtonSelectedBackgroundColor: Color.lerp(
        iconButtonSelectedBackgroundColor,
        other.iconButtonSelectedBackgroundColor,
        t,
      ),
      iconButtonSelectedForegroundColor: Color.lerp(
        iconButtonSelectedForegroundColor,
        other.iconButtonSelectedForegroundColor,
        t,
      ),
      mainAppBarColor: Color.lerp(
        mainAppBarColor,
        other.mainAppBarColor,
        t,
      ),
      modalAppBarUnderlineColor: Color.lerp(
        modalAppBarUnderlineColor,
        other.modalAppBarUnderlineColor,
        t,
      ),
      listTileTrailingIconColor: Color.lerp(
        listTileTrailingIconColor,
        other.listTileTrailingIconColor,
        t,
      ),
      drawingToolPanelPickerBackgroundColor: Color.lerp(
        drawingToolPanelPickerBackgroundColor,
        other.drawingToolPanelPickerBackgroundColor,
        t,
      ),
      segmentedControlBackgroundColor: Color.lerp(
        segmentedControlBackgroundColor,
        other.segmentedControlBackgroundColor,
        t,
      ),
      segmentedControlSelectedColor: Color.lerp(
        segmentedControlSelectedColor,
        other.segmentedControlSelectedColor,
        t,
      ),
    );
  }
}

extension AppColorsExtension on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
