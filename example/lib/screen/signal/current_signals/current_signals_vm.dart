import 'package:chart_iq/chart_iq.dart';
import 'package:flutter/material.dart';

class CurrentSignalsVM extends ChangeNotifier {
  CurrentSignalsVM({
    required this.chartIQController,
  }) {
    getSignals();
  }

  final ChartIQController chartIQController;

  List<Signal> signals = [];

  Future<void> getSignals() async {
    signals = await chartIQController.signal.getActiveSignals();
    notifyListeners();
  }

  Future<void> toggleSignal(int index, bool value) async {
    await chartIQController.signal.toggleSignal(signals[index]);
    getSignals();
  }

  Future<void> removeSignal(int index, Signal signal) async {
    signals.removeAt(index);
    notifyListeners();
    await chartIQController.signal.removeSignal(signal);
    getSignals();
  }
}
