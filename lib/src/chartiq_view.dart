import 'dart:async';
import 'dart:convert';

import 'package:chart_iq/chart_iq.dart';
import 'package:chart_iq/src/model/chart_available_model.dart';
import 'package:chart_iq/src/model/data_pull_model.dart';
import 'package:chart_iq/src/model/measure_model.dart';
import 'package:chart_iq/src/model/message_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controller/chartiq_controller_impl.dart';

/// A widget that displays a chart.
///
/// This widget is a wrapper around the WebView.
///
/// The widget will display a chart when the [chartIQUrl] is set.
/// The [chartIQUrl] is the url of the chart.
/// The [onChartIQViewCreated] is called when the chart is created and will return [ChartIQController].
class ChartIQView extends StatefulWidget {
  /// A callback that is called when the chart is created. See [ChartIQController].
  final ValueSetter<ChartIQController>? onChartIQViewCreated;

  /// A callback that is called when the chart needs initial Data. See [QuoteFeedParams].
  final ValueSetter<QuoteFeedParams> onPullInitialData;

  /// A callback that is called when the chart needs update Data. See [QuoteFeedParams].
  final ValueSetter<QuoteFeedParams> onPullUpdateData;

  /// A callback that is called when the chart needs pagination Data. See [QuoteFeedParams].
  final ValueSetter<QuoteFeedParams> onPullPaginationData;

  /// The url of the chart.
  final String chartIQUrl;

  const ChartIQView({
    Key? key,
    required this.chartIQUrl,
    required this.onPullInitialData,
    required this.onPullUpdateData,
    required this.onPullPaginationData,
    this.onChartIQViewCreated,
  }) : super(key: key);

  @override
  State<ChartIQView> createState() => _ChartIQViewState();
}

class _ChartIQViewState extends State<ChartIQView> {
  late final ChartIQController _controllerForChartIQ = ChartIQControllerImpl(
      _channel, _onChartAvailable.stream, _onMeasureListener.stream);
  static const String _webViewKey = 'plugins.com.chartiq.chart_flutter_sdk/';
  final String _webViewKeyChannel = '${_webViewKey}chartiqwebview';
  final String _webViewKeyEvents = '${_webViewKey}chartiqwebview_events';
  late MethodChannel _channel;
  late EventChannel _eventChannel;
  StreamSubscription? _eventStream;
  final StreamController<bool> _onChartAvailable = StreamController.broadcast();
  final StreamController<String> _onMeasureListener =
      StreamController.broadcast();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildWebView();
  }

  Widget _buildWebView() {
    final Map<String, dynamic> creationParams = <String, dynamic>{};
    creationParams['url'] = widget.chartIQUrl;
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: _webViewKeyChannel,
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: _webViewKeyChannel,
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    return Text('$defaultTargetPlatform is not yet supported by the plugin');
  }

  _onPlatformViewCreated(int id) {
    _channel = MethodChannel('${_webViewKeyChannel}_$id');
    _eventChannel = EventChannel('${_webViewKeyEvents}_$id');
    if (defaultTargetPlatform == TargetPlatform.android) {
      widget.onChartIQViewCreated?.call(_controllerForChartIQ);
    }
    _subForEvents();
  }

  _subForEvents() {
    _eventStream = _eventChannel.receiveBroadcastStream().listen((event) {
      final map = jsonDecode(event);
      final String type = map["type"];
      final MessageType messageType =
          MessageType.values.firstWhere((e) => e.name == type);
      bool isCurrent = ModalRoute.of(context)?.isCurrent ?? false;
      _channel.invokeMethod("changeAvailability", isCurrent);
      switch (messageType) {
        case MessageType.pullInitialData:
          final DataPullModel dataPullModel = DataPullModel.fromJson(map);
          widget.onPullInitialData(dataPullModel.params);
          break;
        case MessageType.pullUpdateData:
          final DataPullModel dataPullModel = DataPullModel.fromJson(map);
          widget.onPullUpdateData(dataPullModel.params);
          break;
        case MessageType.pullPaginationData:
          final DataPullModel dataPullModel = DataPullModel.fromJson(map);
          widget.onPullPaginationData(dataPullModel.params);
          break;
        case MessageType.chartAvailable:
          final ChartAvailableModel model = ChartAvailableModel.fromJson(map);
          _onChartAvailable.sink.add(model.available);
          break;
        case MessageType.chartReady:
          _onChartReady();
          break;
        case MessageType.measure:
          final MeasureModel model = MeasureModel.fromJson(map);
          if (model.measure != null) {
            _onMeasureListener.sink.add(model.measure!);
          }
          break;
        default:
          break;
      }
    });
  }

  _onChartReady() async {
    widget.onChartIQViewCreated?.call(_controllerForChartIQ);
  }

  @override
  void dispose() {
    _eventStream?.cancel();
    _onChartAvailable.close();
    _onMeasureListener.close();
    super.dispose();
  }
}
