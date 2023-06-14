import 'package:chartiq_flutter_sdk/chartiq_flutter_sdk.dart';

/// The model that contains the study info for the signal study.
///
/// This information is needed to remove all the studies if [Study] was added to the [Signal]
/// but [Signal] wasn't saved as [Study] adds to the list of all chart studies and can't be auto-removed.
class SignalStudyInfoModel {
  static final SignalStudyInfoModel _instance = SignalStudyInfoModel._();

  SignalStudyInfoModel._();

  static SignalStudyInfoModel get instance => _instance;

  List<Study> studies = [];

  void clear() {
    studies.clear();
  }

  void removeLast() {
    if (studies.isNotEmpty) studies.removeLast();
  }
}
