import 'package:chart_iq/chartiq_flutter_sdk.dart';
import 'package:defer_pointer/defer_pointer.dart';
import 'package:example/common/widgets/animations/custom_fade_in_container.dart';
import 'package:example/common/widgets/custom_expandable_body.dart';
import 'package:example/common/widgets/modals/app_bottom_sheet.dart';
import 'package:example/common/widgets/spacing.dart';
import 'package:example/data/model/drawing_tool/drawing_tool_item_model.dart';
import 'package:example/data/model/drawing_tool/instrument/instrument_item_model.dart';
import 'package:example/gen/assets.gen.dart';
import 'package:example/routes/screen_names.dart';
import 'package:example/screen/drawing_tools/drawing_tools_page.dart';
import 'package:example/screen/home/main_vm.dart';
import 'package:example/screen/home/widgets/drawing_tool_panel/drawing_tool_panel_vm.dart';
import 'package:example/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'color_picker/panel_color_picker.dart';
import 'line_picker/panel_line_picker.dart';
import 'panel_buttons/panel_color_with_icon_button.dart';
import 'panel_buttons/panel_icon_button.dart';

class DrawingToolSettingsPanel extends StatefulWidget {
  const DrawingToolSettingsPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawingToolSettingsPanel> createState() =>
      _DrawingToolSettingsPanelState();
}

class _DrawingToolSettingsPanelState extends State<DrawingToolSettingsPanel> {
  @override
  void initState() {
    super.initState();
    context.read<DrawingToolPanelVM>().setupInstrumentsList();
  }

  void _onInstrumentSelected(InstrumentItemModel instrument) {
    final vm = context.read<DrawingToolPanelVM>();
    if (instrument == vm.selectedInstrument) {
      vm.onInstrumentChanged(null);
    } else {
      vm.onInstrumentChanged(instrument);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DrawingToolPanelVM>();
    return DeferredPointerHandler(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (vm.selectedInstrument is InstrumentColor)
            Positioned(
              top: -70,
              child: DeferPointer(
                child: CustomFadeInContainer(
                  child: PanelColorPicker(
                    key: const ValueKey(InstrumentColor),
                    selectedColor: (vm.selectedInstrument! as InstrumentColor).color,
                    onColorSelected: (color) =>
                        vm.updateColorParameter(DrawingParameterType.lineColor, color),
                  ),
                ),
              ),
            ),
          if (vm.selectedInstrument is InstrumentFill)
            Positioned(
              top: -70,
              child: DeferPointer(
                child: CustomFadeInContainer(
                  child: PanelColorPicker(
                    key: const ValueKey(InstrumentFill),
                    selectedColor: (vm.selectedInstrument! as InstrumentFill).color,
                    onColorSelected: (color) =>
                        vm.updateColorParameter(DrawingParameterType.fillColor, color),
                  ),
                ),
              ),
            ),
          if (vm.selectedInstrument is InstrumentLineType)
            Positioned(
              top: -70,
              child: DeferPointer(
                child: CustomFadeInContainer(
                  child: PanelLinePicker(
                    key: const ValueKey(InstrumentLineType),
                    selectedLineType:
                        (vm.selectedInstrument as InstrumentLineType).line,
                    onLineTypeSelected: vm.updateLineParameter,
                  ),
                ),
              ),
            ),
          CustomExpandableBody(
            expand: vm.isControllerAvailable && vm.drawingTool != null,
            child: SafeArea(
              top: false,
              child: Container(
                height: 44,
                color: context.colors.iconButtonSelectedForegroundColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: vm.instruments.length,
                    itemBuilder: (context, index) {
                      return _resolveInstrumentBuilder(
                          context, vm.instruments[index]);
                    },
                    separatorBuilder: (context, index) =>
                        const HorizontalSpacing(16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _resolveInstrumentBuilder(
      BuildContext context, InstrumentItemModel model) {
    final vm = context.watch<DrawingToolPanelVM>();
    switch (model.runtimeType) {
      case InstrumentDrawingTool:
        return PanelIconButton(
          icon: (model as InstrumentDrawingTool).icon,
          isSelected: model == vm.selectedInstrument,
          onSelected: () {
            vm.onInstrumentChanged(null);
            final mainVM = context.read<MainVM>();
            showAppBottomSheet<DrawingToolItemModel>(
              context: context,
              builder: (_) {
                return ChangeNotifierProvider.value(
                  value: mainVM,
                  builder: (_, __) => const DrawingToolsPage(),
                );
              },
            );
          },
        );
      case InstrumentColor:
        return PanelColorWithIconButton(
          icon: Assets.icons.borderColor.path,
          currentColor: (model as InstrumentColor).color,
          isSelected: model == vm.selectedInstrument,
          onSelected: () => _onInstrumentSelected(model),
        );
      case InstrumentFill:
        return PanelColorWithIconButton(
          icon: Assets.icons.panelFill.path,
          currentColor: (model as InstrumentFill).color,
          isSelected: model == vm.selectedInstrument,
          onSelected: () => _onInstrumentSelected(model),
        );
      case InstrumentLineType:
        return PanelIconButton(
          icon: (model as InstrumentLineType).line.icon,
          isSelected: model == vm.selectedInstrument,
          onSelected: () => _onInstrumentSelected(model),
        );
      case InstrumentSettings:
        return PanelIconButton(
          icon: Assets.icons.drawSettings.path,
          isSelected: model == vm.selectedInstrument,
          onSelected: () {
            vm.onInstrumentChanged(null);
            Navigator.pushNamed(context, ScreenNames.drawingToolsSettings,
                arguments: {
                  'drawingTool': vm.drawingTool,
                  'chartIQController': vm.chartIQController,
                  'drawingToolPanelVM': vm,
                });
            /*Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider<DrawingToolsSettingsVM>(
                  create: (_) => DrawingToolsSettingsVM(
                    drawingTool: _drawingTool!,
                    chartIQController: widget.chartIQController!,
                  ),
                  child: const DrawingToolsSettingsScreen(),
                ),
              ),
            );*/
          },
        );
      default:
        return const SizedBox();
    }
  }
}
