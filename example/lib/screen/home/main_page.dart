import 'dart:async';

import 'package:chartiq_flutter_sdk/chartiq_flutter_sdk.dart';
import 'package:example/common/utils/confirmation_dialog.dart';
import 'package:example/providers/locale_provider.dart';
import 'package:example/screen/home/widgets/drawing_action_buttons.dart';
import 'package:example/screen/home/widgets/drawing_tool_panel/drawing_tool_panel_vm.dart';
import 'package:example/screen/home/widgets/measure_info_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_vm.dart';
import 'widgets/crosshairs/crosshair_view.dart';
import 'widgets/draggable_full_view_focused_button.dart';
import 'widgets/drawing_tool_panel/drawing_tool_panel.dart';
import 'widgets/main_app_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final StreamSubscription<bool> internetSubscription;
  bool previousInternetAvailability = true;
  final String _chartIQUrl =
      'https://mobile.demo.chartiq.com/android/3.3.0/sample-template-native-sdk.html';

  @override
  void initState() {
    super.initState();
    final vm = context.read<MainVM>();
    final window = WidgetsBinding.instance.window;
    window.onPlatformBrightnessChanged = () {
      WidgetsBinding.instance.handlePlatformBrightnessChanged();
      vm.onPlatformBrightnessChanged(window.platformBrightness);
    };

    vm.isInternetAvailableStreamController.stream.listen((isAvailableEvent) {
      if (previousInternetAvailability == isAvailableEvent) return;
      if (!isAvailableEvent) _showOfflineDialog(context);
      previousInternetAvailability = isAvailableEvent;
    });
  }

  Future<void> _showOfflineDialog(BuildContext context) async {
    final answer = await showConfirmationDialog(
      context,
      'Something went wrong',
      'The internet connection appears to be offline',
      'Reconnect',
      isConfirmDangerousAction: false,
    );

    if (!mounted || !(answer ?? false)) return;
    final vm = context.read<MainVM>();

    if (!await vm.checkInternetAvailability()) {
      if (!mounted) return;
      return _showOfflineDialog(context);
    }
    await vm.onSymbolSelected(vm.selectedSymbol);
    await vm.init();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MainVM>(context);
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          MainAppBar(
            isCollapsed: isPortrait ? false : vm.isAppBarCollapsed,
            onExpandButtonPressed: vm.collapseAppBar,
          ),
          CrosshairView(
            isExpanded: vm.isCrosshairEnabled,
            data: vm.crosshairHUDData,
          ),
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  ChartIQView(
                    chartIQUrl: _chartIQUrl,
                    onPullInitialData: vm.onPullInitialData,
                    onPullUpdateData: vm.onPullUpdateData,
                    onPullPaginationData: vm.onPullPaginationData,
                    onChartIQViewCreated: (controller) {
                      vm.onChartIQViewCreated(controller);
                      final l = context.read<LocaleProvider>();
                      l.set(l.appLanguage, controller);
                    },
                  ),
                  if (vm.selectedDrawingTool != null && vm.isAppBarCollapsed)
                    Positioned(
                      top: 10,
                      child: DrawingActionButtons(
                        onUndo: vm.onUndoDrawing,
                        onRedo: vm.onRedoDrawing,
                      ),
                    ),
                  if (vm.isAppBarCollapsed && vm.chartIQController != null)
                    Positioned(
                      top: 50,
                      child: MeasureInfoLabel(
                        chartIQController: vm.chartIQController!,
                      ),
                    ),
                  if (!isPortrait && vm.isAppBarCollapsed)
                    DraggableFullViewFocusedButton(
                      isAppBarCollapsed: vm.isAppBarCollapsed,
                      onPressed: vm.collapseAppBar,
                      constraints: constraints,
                    ),
                ],
              );
            }),
          ),
          if (vm.chartIQController != null)
            ChangeNotifierProxyProvider<MainVM, DrawingToolPanelVM>(
              create: (_) => DrawingToolPanelVM(
                chartIQController: vm.chartIQController,
                drawingTool: vm.selectedDrawingTool,
                isDrawingToolReset: vm.isDrawingToolReset,
              ),
              update: (_, mainVM, drawingToolPanelVM) =>
                  drawingToolPanelVM!..updateVM(mainVM),
              child: const DrawingToolSettingsPanel(),
            ),
        ],
      ),
    );
  }
}
