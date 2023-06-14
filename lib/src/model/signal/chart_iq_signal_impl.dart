import 'dart:convert';

import 'package:chartiq_flutter_sdk/src/model/signal/chart_iq_signal.dart';
import 'package:chartiq_flutter_sdk/src/model/signal/signal.dart';
import 'package:chartiq_flutter_sdk/src/model/study/study.dart';
import 'package:flutter/services.dart';

class ChartIQSignalImpl extends ChartIQSignal {
  final MethodChannel channel;

  ChartIQSignalImpl({required this.channel});

  @override
  Future<Study> addSignalStudy(String name) async {
    final res = await channel
        .invokeMethod('addSignalStudy', name);
    return Study.fromJson(jsonDecode(res));
  }

  @override
  Future<List<Signal>> getActiveSignals() async {
    final res = await channel.invokeMethod('getActiveSignals');
    final List<dynamic> json = jsonDecode(res);
    return json.map((e) => Signal.fromJson(e)).toList();
  }

  @override
  Future<void> removeSignal(Signal signal) {
    return channel.invokeMethod('removeSignal', jsonEncode(signal.toJson()));
  }

  @override
  Future<void> saveSignal(Signal signal, bool editMode) {
    return channel
        .invokeMethod('saveSignal', [jsonEncode(signal.toJson()), editMode]);
  }

  @override
  Future<void> toggleSignal(Signal signal) {
    return channel.invokeMethod('toggleSignal', jsonEncode(signal.toJson()));
  }
}
