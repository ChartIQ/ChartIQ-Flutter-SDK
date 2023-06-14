import 'package:chartiq_flutter_sdk/chartiq_flutter_sdk.dart';
import 'package:example/common/const/locale_keys.dart';
import 'package:example/data/model/chart_style_item_type_model.dart';
import 'package:example/gen/assets.gen.dart';

extension ChartTypeModelConvertExtension on ChartType {
  String _getTitle() {
    switch (this) {
      case ChartType.candle:
        return RemoteLocaleKeys.candle;
      case ChartType.bar:
        return RemoteLocaleKeys.bar;
      case ChartType.coloredBar:
        return RemoteLocaleKeys.coloredBar;
      case ChartType.line:
        return RemoteLocaleKeys.line;
      case ChartType.vertexLine:
        return RemoteLocaleKeys.vertexLine;
      case ChartType.step:
        return RemoteLocaleKeys.step;
      case ChartType.mountain:
        return RemoteLocaleKeys.mountain;
      case ChartType.baseline:
        return RemoteLocaleKeys.baseline;
      case ChartType.hollowCandle:
        return RemoteLocaleKeys.hollowCandle;
      case ChartType.volumeCandle:
        return RemoteLocaleKeys.volumeCandle;
      case ChartType.coloredHLC:
        return RemoteLocaleKeys.coloredHLCBar;
      case ChartType.scatterPlot:
        return RemoteLocaleKeys.scatterPlot;
      case ChartType.histogram:
        return RemoteLocaleKeys.histogram;
    }
  }

  String _getIcon() {
    switch (this) {
      case ChartType.candle:
        return Assets.icons.chartStyle.candles.path;
      case ChartType.bar:
        return Assets.icons.chartStyle.bar.path;
      case ChartType.coloredBar:
        return Assets.icons.chartStyle.coloredBar.path;
      case ChartType.line:
        return Assets.icons.chartStyle.line.path;
      case ChartType.vertexLine:
        return Assets.icons.chartStyle.vertexLine.path;
      case ChartType.step:
        return Assets.icons.chartStyle.step.path;
      case ChartType.mountain:
        return Assets.icons.chartStyle.mountain.path;
      case ChartType.baseline:
        return Assets.icons.chartStyle.baseline.path;
      case ChartType.hollowCandle:
        return Assets.icons.chartStyle.hollowCandle.path;
      case ChartType.volumeCandle:
        return Assets.icons.chartStyle.volumeCandle.path;
      case ChartType.coloredHLC:
        return Assets.icons.chartStyle.coloredBar.path;
      case ChartType.scatterPlot:
        return Assets.icons.chartStyle.scatterPlot.path;
      case ChartType.histogram:
        return Assets.icons.chartStyle.histogram.path;
    }
  }

  ChartTypeItemModel toModel() {
    return ChartTypeItemModel(
      title: _getTitle(),
      name: value,
      icon: _getIcon(),
    );
  }
}

extension ChartAggregationTypeModelConvertExtension on ChartAggregationType {
  String _getTitle() {
    switch (this) {
      case ChartAggregationType.heikinAshi:
        return RemoteLocaleKeys.heikinAshi;
      case ChartAggregationType.kagi:
        return RemoteLocaleKeys.kagi;
      case ChartAggregationType.lineBreak:
        return RemoteLocaleKeys.lineBreak;
      case ChartAggregationType.renko:
        return RemoteLocaleKeys.renko;
      case ChartAggregationType.rangeBars:
        return RemoteLocaleKeys.rangeBars;
      case ChartAggregationType.pAndF:
        return RemoteLocaleKeys.pointAndFigure;
    }
  }

  String _getIcon() {
    switch (this) {
      case ChartAggregationType.heikinAshi:
        return Assets.icons.chartStyle.heikinAshi.path;
      case ChartAggregationType.kagi:
        return Assets.icons.chartStyle.kagi.path;
      case ChartAggregationType.lineBreak:
        return Assets.icons.chartStyle.lineBreak.path;
      case ChartAggregationType.renko:
        return Assets.icons.chartStyle.renko.path;
      case ChartAggregationType.rangeBars:
        return Assets.icons.chartStyle.rangeBar.path;
      case ChartAggregationType.pAndF:
        return Assets.icons.chartStyle.pointAndFigure.path;
    }
  }

  ChartTypeItemModel toModel() {
    return ChartTypeItemModel(
      title: _getTitle(),
      name: value,
      icon: _getIcon(),
    );
  }
}
