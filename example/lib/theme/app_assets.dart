import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';

@immutable
class AppAssets extends ThemeExtension<AppAssets> {
  const AppAssets({
    required this.splash,
    required this.drawIcon,
    required this.drawFocusedIcon,
    required this.fullViewFocusedIcon,
    required this.searchIcon,
    required this.drawingTool,
    required this.analysisIcon,
    required this.undoIcon,
    required this.redoIcon,
  });

  final SvgGenImage splash,
      drawIcon,
      drawFocusedIcon,
      fullViewFocusedIcon,
      searchIcon,
      drawingTool,
      analysisIcon,
      undoIcon,
      redoIcon;

  @override
  AppAssets copyWith({
    SvgGenImage? splash,
    SvgGenImage? drawIcon,
    SvgGenImage? drawFocusedIcon,
    SvgGenImage? fullViewFocusedIcon,
    SvgGenImage? searchIcon,
    SvgGenImage? drawingTool,
    SvgGenImage? analysisIcon,
    SvgGenImage? undoIcon,
    SvgGenImage? redoIcon,
  }) {
    return AppAssets(
      splash: splash ?? this.splash,
      drawIcon: drawIcon ?? this.drawIcon,
      drawFocusedIcon: drawFocusedIcon ?? this.drawFocusedIcon,
      fullViewFocusedIcon: fullViewFocusedIcon ?? this.fullViewFocusedIcon,
      searchIcon: searchIcon ?? this.searchIcon,
      drawingTool: drawingTool ?? this.drawingTool,
      analysisIcon: analysisIcon ?? this.analysisIcon,
      undoIcon: undoIcon ?? this.undoIcon,
      redoIcon: redoIcon ?? this.redoIcon,
    );
  }

  @override
  AppAssets lerp(ThemeExtension<AppAssets>? other, double t) {
    if (other is! AppAssets) {
      return this;
    }
    return AppAssets(
      splash: splash,
      drawIcon: drawIcon,
      drawFocusedIcon: drawFocusedIcon,
      fullViewFocusedIcon: fullViewFocusedIcon,
      searchIcon: searchIcon,
      drawingTool: drawingTool,
      analysisIcon: analysisIcon,
      undoIcon: undoIcon,
      redoIcon: redoIcon,
    );
  }
}

extension AppAssetsExtension on BuildContext {
  AppAssets get assets => Theme.of(this).extension<AppAssets>()!;
}
