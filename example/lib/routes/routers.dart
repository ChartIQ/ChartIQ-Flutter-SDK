import 'dart:ui';

import 'package:example/data/api/chart/chart_api.dart';
import 'package:example/data/api_const.dart';
import 'package:example/routes/screen_names.dart';
import 'package:example/screen/drawing_tools_settings/drawing_tools_settings_page.dart';
import 'package:example/screen/drawing_tools_settings/drawing_tools_settings_vm.dart';
import 'package:example/screen/home/main_page.dart';
import 'package:example/screen/home/widgets/drawing_tool_panel/drawing_tool_panel_vm.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../data/provider/api_provider.dart';
import '../screen/home/main_vm.dart';
import '../screen/splash/splash_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case ScreenNames.splash:
        page = const SplashPage();
        break;
      case ScreenNames.main:
        page = ChangeNotifierProvider(
          create: (context) => MainVM(
            ChartApi(ApiProvider(ApiConst.hostSimulator)),
          ),
          child: const MainPage(),
        );
        break;
      case ScreenNames.drawingToolsSettings:
        {
          final args = settings.arguments as Map<String, dynamic>;
          page = MultiProvider(
            providers: [
              ChangeNotifierProvider<DrawingToolPanelVM>.value(
                value: args['drawingToolPanelVM'],
              ),
              ChangeNotifierProxyProvider<DrawingToolPanelVM,
                  DrawingToolsSettingsVM>(
                create: (context) => DrawingToolsSettingsVM(
                  drawingTool: args['drawingTool'],
                  chartIQController: args['chartIQController'],
                ),
                update: (context, panelVM, settingsVM) =>
                    settingsVM!..updateVM(panelVM),
              ),
            ],
            child: const DrawingToolsSettingsScreen(),
          );
        }
        break;
      default:
        page = Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        );
    }

    final logicalSize = window.physicalSize / window.devicePixelRatio;

    if (logicalSize.shortestSide <= 700) {
      return MaterialWithModalsPageRoute(
        builder: (context) => page,
        settings: settings,
      );
    }

    return MaterialPageRoute(
      builder: (context) => page,
      settings: settings,
    );
  }
}
