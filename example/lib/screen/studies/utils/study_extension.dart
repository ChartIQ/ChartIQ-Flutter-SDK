import 'package:chartiq_flutter_sdk/chartiq_flutter_sdk.dart';
import 'package:example/common/const/const.dart';

extension StudyExtension on Study {
  static const kZeroWidthNonJoiner = AppConst.kZeroWidthNonJoiner;

  static List<String> splitName(String name) {
    final nameWithoutLeading = name.replaceFirst(
      kZeroWidthNonJoiner.toString(),
      '',
    );
    if (nameWithoutLeading.split(kZeroWidthNonJoiner).length == 1) {
      return [nameWithoutLeading.trim(), ''];
    } else {
      final indexOfDelimiter = nameWithoutLeading.indexOf(kZeroWidthNonJoiner);
      return [
        nameWithoutLeading.substring(0, indexOfDelimiter).trim(),
        nameWithoutLeading
            .substring(indexOfDelimiter)
            .replaceAll(kZeroWidthNonJoiner.toString(), '')
            .trim()
      ];
    }
  }

  Study copyWithSimplified(StudySimplified simplified) {
    return Study(
      name: simplified.studyName,
      shortName: simplified.studyName,
      outputs: simplified.outputs,
      type: type,
      attributes: attributes,
      centerLine: centerLine,
      customRemoval: customRemoval,
      deferUpdate: deferUpdate,
      overlay: overlay,
      inputs: inputs,
      parameters: parameters,
      yAxis: yAxis,
      signalIQExclude: signalIQExclude,
      underlay: underlay,
      display: display,
      range: range,
    );
  }
}
