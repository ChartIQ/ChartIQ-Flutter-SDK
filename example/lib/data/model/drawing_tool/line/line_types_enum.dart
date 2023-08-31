import 'package:example/data/model/drawing_tool/line/line_type_enum.dart';
import 'package:example/gen/assets.gen.dart';

enum LineTypes {
  solid(LineType.solid, 1),
  solidBold(LineType.solid, 2),
  solidBoldest(LineType.solid, 3),
  dotted(LineType.dotted, 1),
  dottedBold(LineType.dotted, 2),
  dashed(LineType.dashed, 1),
  dashedBold(LineType.dashed, 2);

  final LineType type;
  final int width;

  const LineTypes(this.type, this.width);

  String get icon {
    switch (this) {
      case LineTypes.solid:
        return Assets.icons.lineTypes.solid.path;
      case LineTypes.solidBold:
        return Assets.icons.lineTypes.solidBold.path;
      case LineTypes.solidBoldest:
        return Assets.icons.lineTypes.solidBoldest.path;
      case LineTypes.dotted:
        return Assets.icons.lineTypes.dotted.path;
      case LineTypes.dottedBold:
        return Assets.icons.lineTypes.dottedBold.path;
      case LineTypes.dashed:
        return Assets.icons.lineTypes.dash.path;
      case LineTypes.dashedBold:
        return Assets.icons.lineTypes.dashBold.path;
    }
  }

  static LineTypes getFromParameters(LineType? lineType, int? lineWidth) {
    return LineTypes.values.firstWhere(
      (element) => element.type == lineType && element.width == lineWidth,
      orElse: () {
        if (lineType != null) {
          return [
            LineTypes.solid,
            LineTypes.dotted,
            LineTypes.dashed,
          ].firstWhere(
            (e) => e.type == lineType,
          );
        }
        if (lineWidth != null) {
          return [
            LineTypes.solid,
            LineTypes.solidBold,
            LineTypes.solidBoldest,
          ].firstWhere(
            (e) => e.width == lineWidth,
          );
        }
        return LineTypes.solid;
      },
    );
  }
}
