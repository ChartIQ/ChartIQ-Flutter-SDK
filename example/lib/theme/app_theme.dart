import 'package:example/gen/assets.gen.dart';
import 'package:example/theme/app_colors.dart';
import 'package:example/theme/app_crosshair_text_theme.dart';
import 'package:example/theme/app_text_field_theme.dart';
import 'package:flutter/material.dart';

import '../gen/colors.gen.dart';
import 'app_assets.dart';

class AppTheme {
  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() => _instance;

  AppTheme._internal();

  ThemeData get theme => ThemeData.light().copyWith(
        brightness: Brightness.light,
        scaffoldBackgroundColor: ColorName.white,
        colorScheme: const ColorScheme.light(
          primary: ColorName.darkElectricBlue,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorName.ghostWhite,
          foregroundColor: ColorName.darkElectricBlue,
          titleTextStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: ColorName.black,
          ),
        ),
        iconTheme: const IconThemeData(
          color: ColorName.darkElectricBlue,
        ),
        listTileTheme: const ListTileThemeData(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          tileColor: ColorName.white,
        ),
        dividerTheme: const DividerThemeData(
          color: ColorName.dividerLight,
          thickness: 0.3,
          space: 0.3,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: ColorName.paleGrey,
            foregroundColor: ColorName.darkElectricBlue,
            disabledForegroundColor:
                ColorName.darkElectricBlue.withOpacity(0.5),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
          ),
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: ColorName.darkElectricBlue,
          ),
          titleSmall: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: ColorName.cadetBlue,
          ),
          labelMedium: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: ColorName.cadetBlue,
          ),
          labelSmall: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: ColorName.darkElectricBlue,
          ),
          labelLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: ColorName.cadetBlue,
          ),
        ),
        chipTheme: const ChipThemeData(
          backgroundColor: ColorName.white,
          selectedColor: ColorName.white,
          labelPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          padding: EdgeInsets.zero,
          labelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: ColorName.darkElectricBlue,
          ),
          brightness: Brightness.light,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            side: BorderSide(
              color: ColorName.gainsboro,
              width: 1,
            ),
          ),
          pressElevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorName.mountainMeadow,
            foregroundColor: ColorName.white,
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 19,
              vertical: 19,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        extensions: <ThemeExtension<dynamic>>[
          AppColors(
            iconButtonBackgroundColor: ColorName.brightGrey,
            iconButtonSelectedBackgroundColor: ColorName.darkElectricBlue,
            iconButtonSelectedForegroundColor: ColorName.paleGrey,
            mainAppBarColor: ColorName.ghostWhite.withOpacity(.9),
            modalAppBarUnderlineColor: ColorName.black.withOpacity(.3),
            listTileTrailingIconColor: ColorName.gainsboro,
            drawingToolPanelPickerBackgroundColor: ColorName.white,
            segmentedControlBackgroundColor: ColorName.paleGrey,
            segmentedControlSelectedColor: ColorName.white,
          ),
          AppAssets(
            splash: Assets.icons.splashLight,
            drawIcon: Assets.icons.drawLight,
            drawFocusedIcon: Assets.icons.drawFocusedLight,
            fullViewFocusedIcon: Assets.icons.fullViewFocusedLight,
            searchIcon: Assets.icons.searchLight,
            drawingTool: Assets.icons.drawingToolLight,
            analysisIcon: Assets.icons.analysisLight,
            undoIcon: Assets.icons.undoLight,
            redoIcon: Assets.icons.redoLight,
          ),
          AppTextFieldTheme(
            iconsColor: ColorName.charcoalGrey.withOpacity(.6),
            backgroundColor: ColorName.battleshipGrey.withOpacity(.12),
            textStyle: const TextStyle(
              fontSize: 17,
              color: ColorName.black,
            ),
            placeholderStyle: TextStyle(
              fontSize: 17,
              color: ColorName.charcoalGrey.withOpacity(.6),
            ),
          ),
          const AppCrosshairTextTheme(
            labelTextStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorName.darkElectricBlue,
            ),
            valueTextStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: ColorName.yankeesBlue,
            ),
          ),
        ],
      );

  ThemeData get darkTheme => ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ColorName.darkGunmetal,
        colorScheme: const ColorScheme.light(
          primary: ColorName.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorName.chineseBlack,
          foregroundColor: ColorName.white,
          titleTextStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: ColorName.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: ColorName.white,
        ),
        listTileTheme: const ListTileThemeData(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          tileColor: ColorName.darkGunmetal,
        ),
        dividerTheme: const DividerThemeData(
          color: ColorName.outerSpace,
          thickness: 1,
          space: 1,
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: ColorName.white,
          ),
          titleSmall: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: ColorName.cadetBlue,
          ),
          labelMedium: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: ColorName.cadetBlue,
          ),
          labelSmall: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: ColorName.white,
            letterSpacing: 0.2,
          ),
          labelLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: ColorName.cadetBlue,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: ColorName.yankeesBlue,
            foregroundColor: ColorName.white,
            disabledForegroundColor: ColorName.white.withOpacity(0.5),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
          ),
        ),
        chipTheme: const ChipThemeData(
          backgroundColor: ColorName.darkGunmetal,
          selectedColor: ColorName.darkGunmetal,
          labelPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          padding: EdgeInsets.zero,
          labelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: ColorName.white,
          ),
          brightness: Brightness.dark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            side: BorderSide(
              color: ColorName.outerSpace,
              width: 1,
            ),
          ),
          pressElevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorName.mountainMeadow,
            foregroundColor: ColorName.white,
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 19,
              vertical: 19,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        extensions: <ThemeExtension<dynamic>>[
          AppColors(
            iconButtonBackgroundColor: ColorName.yankeesBlue,
            iconButtonSelectedBackgroundColor: ColorName.white,
            iconButtonSelectedForegroundColor: ColorName.yankeesBlue,
            mainAppBarColor: ColorName.darkGunmetal,
            modalAppBarUnderlineColor: ColorName.ghostWhite.withOpacity(.3),
            listTileTrailingIconColor: ColorName.darkElectricBlue,
            drawingToolPanelPickerBackgroundColor: ColorName.darkGunmetal,
            segmentedControlBackgroundColor: ColorName.darkGunmetal,
            segmentedControlSelectedColor: ColorName.yankeesBlue,
          ),
          AppAssets(
            splash: Assets.icons.splashDark,
            drawIcon: Assets.icons.drawDark,
            drawFocusedIcon: Assets.icons.drawFocusedDark,
            fullViewFocusedIcon: Assets.icons.fullViewFocusedDark,
            searchIcon: Assets.icons.searchDark,
            drawingTool: Assets.icons.drawingToolDark,
            analysisIcon: Assets.icons.analysisDark,
            undoIcon: Assets.icons.undoDark,
            redoIcon: Assets.icons.redoDark,
          ),
          AppTextFieldTheme(
            iconsColor: ColorName.paleGrey.withOpacity(.6),
            backgroundColor: ColorName.battleshipGrey.withOpacity(.24),
            textStyle: const TextStyle(
              fontSize: 17,
              color: ColorName.white,
            ),
            placeholderStyle: TextStyle(
              fontSize: 17,
              color: ColorName.paleGrey.withOpacity(.6),
            ),
          ),
          const AppCrosshairTextTheme(
            labelTextStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorName.cadetBlue,
            ),
            valueTextStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: ColorName.mayaBlue,
            ),
          ),
        ],
      );
}
