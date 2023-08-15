import '../study/study.dart';
import 'signal.dart';

abstract class ChartIQSignal {
  /// Toggle signal [Signal]
  /// [signal] A [Signal] to be toggled
  Future<void> toggleSignal(Signal signal);

  /// Gets a list of signals [Signal]
  Future<List<Signal>> getActiveSignals();

  /// Removes a selected signal [Signal] from the list of active studies
  /// [signal] A [Signal] to be deleted
  Future<void> removeSignal(Signal signal);

  /// Add signal [Signal] to a list of active signals
  /// [study] A [Study] to be added
  Future<Study> addSignalStudy(Study study);

  /// Save signal [Signal]  to a list of active signals
  /// [signal] A [Signal] to be added
  Future<void> saveSignal(Signal signal, bool editMode);
}
