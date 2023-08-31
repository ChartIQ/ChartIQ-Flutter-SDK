import 'package:example/data/model/drawing_tool/instrument/instrument_enum.dart';
import 'package:example/data/model/drawing_tool/line/line_types_enum.dart';
import 'package:example/data/model/picker_color.dart';
import 'package:example/gen/assets.gen.dart';

class InstrumentItemModel {
  final Instrument instrument;

  const InstrumentItemModel._({required this.instrument});

  factory InstrumentItemModel.drawingTool({
    required String icon,
  }) = InstrumentDrawingTool;

  factory InstrumentItemModel.fill({
    required PickerColor color,
  }) = InstrumentFill;

  factory InstrumentItemModel.color({
    required PickerColor color,
  }) = InstrumentColor;

  factory InstrumentItemModel.line({
    required LineTypes line,
  }) = InstrumentLineType;

  factory InstrumentItemModel.settings() = InstrumentSettings;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InstrumentItemModel &&
          runtimeType == other.runtimeType &&
          instrument == other.instrument;

  @override
  int get hashCode => instrument.hashCode;
}

class InstrumentDrawingTool extends InstrumentItemModel {
  final String icon;

  const InstrumentDrawingTool({
    required this.icon,
  }) : super._(instrument: Instrument.drawingTool);
}

class InstrumentFill extends InstrumentItemModel {
  final PickerColor color;

  const InstrumentFill({
    required this.color,
  }) : super._(instrument: Instrument.fill);
}

class InstrumentColor extends InstrumentItemModel {
  final PickerColor color;

  const InstrumentColor({
    required this.color,
  }) : super._(instrument: Instrument.color);
}

class InstrumentLineType extends InstrumentItemModel {
  final LineTypes line;

  const InstrumentLineType({
    required this.line,
  }) : super._(instrument: Instrument.lineType);
}

class InstrumentSettings extends InstrumentItemModel {
  final String icon = Assets.icons.navSettings.path;

  InstrumentSettings() : super._(instrument: Instrument.color);
}
