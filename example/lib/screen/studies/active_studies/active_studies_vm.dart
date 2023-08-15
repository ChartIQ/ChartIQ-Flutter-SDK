import 'package:chart_iq/chartiq_flutter_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ActiveStudiesVM extends ChangeNotifier {
  final ChartIQController? chartIQController;

  ActiveStudiesVM({
    required this.chartIQController,
  }) {
    getActiveStudies();
  }

  bool get isControllerAvailable => chartIQController != null;

  bool isLoading = false;

  List<Study> studies = [];

  Future<void> getActiveStudies() async {
    if (!isControllerAvailable) return;
    studies = await chartIQController!.study.getActiveStudies();
    notifyListeners();
  }

  Future<void> removeStudy(Study study) async {
    if (!isControllerAvailable) return;
    isLoading = true;
    studies.removeWhere((element) => element.name == study.name);
    notifyListeners();


    await chartIQController!.study.removeStudy(study);
    isLoading = false;
    getActiveStudies();
  }

  Future<void> cloneStudy(Study study) async {
    if (!isControllerAvailable) return;

    isLoading = true;
    notifyListeners();

    await chartIQController!.study.addStudy(study, true);
    isLoading = false;
    getActiveStudies();
  }
}
