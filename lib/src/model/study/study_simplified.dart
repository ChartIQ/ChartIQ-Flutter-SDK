import 'package:collection/collection.dart';

/// Encapsulates parameters with additional information for Study. ChartIQ uses the term “study” to refer to any indicator, oscillator, average, or signal that results from technical analysis of chart data.

class StudySimplified {
  /// The study's ID. Includes ZWNJ characters. Please note: To facilitate study name translations, study names use zero-width non-joiner (unprintable) characters to delimit the general study name from the specific study parameters. Example: "\u200c"+"Aroon"+"\u200c"+" (14)".
  final String studyName;

  /// Names and values (colors) of outputs
  Map<String, String>? outputs;

  /// The type of study, which can be used as a look up in the StudyLibrary
  final String type;

  StudySimplified({
    required this.studyName,
    this.outputs,
    required this.type,
  });

  factory StudySimplified.fromJson(Map<String, dynamic> json) {
    return StudySimplified(
      studyName: json['studyName'],
      outputs: json['outputs'] != null
          ? Map<String, String>.from(json['outputs'])
          : null,
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studyName'] = studyName;
    if (outputs != null) {
      data['outputs'] = outputs!.map((key, value) => MapEntry(key, value));
    }
    data['type'] = type;
    return data;
  }

  @override
  int get hashCode => studyName.hashCode ^ type.hashCode ^ outputs.hashCode;

  @override
  bool operator ==(Object other) =>
      other is StudySimplified &&
      studyName == other.studyName &&
      type == other.type &&
      const DeepCollectionEquality().equals(outputs, other.outputs);
}
