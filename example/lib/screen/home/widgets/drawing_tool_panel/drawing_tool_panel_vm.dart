import 'package:chart_iq/chart_iq.dart';
import 'package:example/data/model/drawing_tool/drawing_tool_item_model.dart';
import 'package:example/data/model/drawing_tool/instrument/instrument_item_model.dart';
import 'package:example/data/model/drawing_tool/line/line_types_enum.dart';
import 'package:example/data/model/drawing_tool/panel_drawing_tool_parameter.dart';
import 'package:example/data/model/picker_color.dart';
import 'package:example/screen/home/main_vm.dart';
import 'package:flutter/material.dart';

class DrawingToolPanelVM extends ChangeNotifier {
  final ChartIQController? chartIQController;
  DrawingToolItemModel? drawingTool;
  bool isDrawingToolReset;

  DrawingToolPanelVM({
    required this.chartIQController,
    required this.drawingTool,
    required this.isDrawingToolReset,
  });

  bool get isControllerAvailable => chartIQController != null;

  final List<InstrumentItemModel> instruments = [];
  InstrumentItemModel? selectedInstrument;

  void updateVM(MainVM newVM) async {
    if (newVM.selectedDrawingTool != drawingTool) {
      drawingTool = newVM.selectedDrawingTool;
      selectedInstrument = null;
      drawingTool == null ? notifyListeners() : setupInstrumentsList();
    }

    if (newVM.isDrawingToolReset != isDrawingToolReset && drawingTool != null) {
      isDrawingToolReset = newVM.isDrawingToolReset;
      selectedInstrument = null;
      await chartIQController?.chartIQDrawingTool
          .enableDrawing(drawingTool!.tool);
      await setupInstrumentsList();
    }
  }

  Future<void> setupInstrumentsList() async {
    if (drawingTool == null) return;

    final parameters = await _fetchParameters(drawingTool!);

    final manager = chartIQController!.drawingManager;

    final futures = await Future.wait([
      manager.isSupportingFillColor(drawingTool!.tool),
      manager.isSupportingLineColor(drawingTool!.tool),
      manager.isSupportingLineType(drawingTool!.tool),
      manager.isSupportingSettings(drawingTool!.tool),
    ]);

    instruments.clear();

    instruments.add(InstrumentItemModel.drawingTool(icon: drawingTool!.icon));

    // fill color
    if (futures[0]) {
      instruments.add(
        InstrumentItemModel.fill(
          color: PickerColor(parameters?.fillColor ?? '#FFFFFF'),
        ),
      );
    }

    // line color
    if (futures[1]) {
      instruments.add(
        InstrumentItemModel.color(
          color: PickerColor(parameters?.color ?? '#FFFFFF'),
        ),
      );
    }

    // line type
    if (futures[2]) {
      instruments.add(
        InstrumentItemModel.line(
          line: LineTypes.getFromParameters(
            parameters?.lineType,
            parameters?.lineWidth,
          ),
        ),
      );
    }

    // settings
    if (futures[3]) {
      instruments.add(InstrumentItemModel.settings());
    }

    notifyListeners();
  }

  void onInstrumentChanged(InstrumentItemModel? instrument) {
    selectedInstrument = instrument;
    notifyListeners();
  }

  Future<PanelDrawingToolParameter?> _fetchParameters(
      DrawingToolItemModel drawingTool) async {
    final map = await chartIQController?.chartIQDrawingTool
        .getDrawingParameters(drawingTool.tool);
    if (map != null) return PanelDrawingToolParameter.fromJson(map);
    return null;
  }

  Future<void> updateParameter(
      DrawingParameterType parameter, String value) async {
    await chartIQController?.chartIQDrawingTool.setDrawingParameterByName(
      parameter.value,
      value,
    );

    selectedInstrument = null;

    notifyListeners();
  }

  Future<void> updateColorParameter(
      DrawingParameterType parameter, PickerColor value) async {
    updateParameter(parameter, value.hexValueWithHash);
    setupInstrumentsList();
  }

  Future<void> updateLineParameter(LineTypes value) async {
    await Future.wait([
      updateParameter(DrawingParameterType.lineWidth, value.width.toString()),
      updateParameter(DrawingParameterType.lineType, value.type.name),
    ]);
    setupInstrumentsList();
  }
}
