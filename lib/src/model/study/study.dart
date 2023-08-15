import 'package:collection/collection.dart';

/// Encapsulates parameters with additional information for Study. ChartIQ uses the term “study” to refer to any indicator, oscillator, average, or signal that results from technical analysis of chart data.
class Study {
  /// The study's ID. Includes ZWNJ characters. Please note: To facilitate study name translations, study names use zero-width non-joiner (unprintable) characters to delimit the general study name from the specific study parameters. Example: "\u200c"+"Aroon"+"\u200c"+" (14)".
  final String name;

  /// Attributes of  the study
  final Map<String, dynamic> attributes;

  /// A center line od the study
  final double centerLine;

  /// A custom removal of the study
  final bool customRemoval;

  /// A defer update of the study
  final bool deferUpdate;

  /// A display name of the study
  final String? display;

  /// Names and values of input fields
  final Map<String, dynamic>? inputs;

  /// Names and values (colors) of outputs
  final Map<String, dynamic>? outputs;

  /// Additional parameters that are unique to the particular study
  final Map<String, dynamic>? parameters;

  /// A range of the study
  final String? range;

  /// A shortName of the study
  final String shortName;

  /// The type of study, which can be used as a look up in the StudyLibrary
  final String? type;

  /// Determines whether the study is an underlay or overlay
  final bool overlay;

  /// Determines whether the study is an underlay or overlay
  final bool underlay;

  /// Y-Axis value of the study
  final Map<String, dynamic>? yAxis;

  /// Determines whether the study should be excluded from SignalIQ
  final bool signalIQExclude;

  /// A original name of the study
  final String? originalName;

  /// A full name of the study
  final String? fullName;

  /// A unique ID of the study
  final String? uniqueId;

  /// A name parameters of the study
  final String? nameParams;

  /// A name of the study
  final String? studyName;

  Study({
    required this.name,
    required this.attributes,
    required this.centerLine,
    required this.customRemoval,
    required this.deferUpdate,
    this.display,
    this.inputs,
    this.outputs,
    this.parameters,
    this.range,
    required this.shortName,
    this.type,
    required this.overlay,
    required this.underlay,
    this.yAxis,
    required this.signalIQExclude,
    this.originalName,
    this.uniqueId,
    this.nameParams,
    this.studyName,
    this.fullName,
  });

  String get displayName =>
      display != null && display!.isNotEmpty ? display! : name;

  factory Study.fromJson(Map<String, dynamic> json) {
    return Study(
      name: json['name'],
      attributes: json['attributes'],
      centerLine: double.parse(json['centerLine'].toString()),
      customRemoval: json['customRemoval'],
      deferUpdate: json['deferUpdate'],
      display: json['display'],
      inputs: json['inputs'],
      outputs: json['outputs'],
      parameters: json['parameters'],
      range: json['range'],
      shortName: json['shortName'],
      type: json['type'].toString(),
      overlay: json['overlay'],
      underlay: json['underlay'],
      yAxis: json['yAxis'],
      signalIQExclude: json['signalIQExclude'],
      originalName: json['originalName'],
      uniqueId: json['uniqueId'],
      nameParams: json['nameParams'],
      studyName: json['studyName'],
      fullName: json['fullName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['attributes'] = attributes;
    data['centerLine'] = centerLine;
    data['customRemoval'] = customRemoval;
    data['deferUpdate'] = deferUpdate;
    data['display'] = display;
    data['inputs'] = inputs;
    data['outputs'] = outputs;
    data['parameters'] = parameters;
    data['range'] = range;
    data['shortName'] = shortName;
    data['type'] = type;
    data['overlay'] = overlay;
    data['underlay'] = underlay;
    data['yAxis'] = yAxis;
    data['signalIQExclude'] = signalIQExclude;
    data['originalName'] = originalName;
    data['uniqueId'] = uniqueId;
    data['nameParams'] = nameParams;
    data['studyName'] = studyName;
    data['fullName'] = fullName;
    return data;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      attributes.hashCode ^
      centerLine.hashCode ^
      customRemoval.hashCode ^
      deferUpdate.hashCode ^
      display.hashCode ^
      inputs.hashCode ^
      outputs.hashCode ^
      parameters.hashCode ^
      range.hashCode ^
      shortName.hashCode ^
      type.hashCode ^
      overlay.hashCode ^
      underlay.hashCode ^
      yAxis.hashCode ^
      signalIQExclude.hashCode ^
      originalName.hashCode ^
      uniqueId.hashCode ^
      nameParams.hashCode ^
      studyName.hashCode ^
      fullName.hashCode;

  @override
  bool operator ==(Object other) {
    final eq = const DeepCollectionEquality().equals;
    return identical(this, other) ||
        other is Study &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            eq(attributes, other.attributes) &&
            centerLine == other.centerLine &&
            customRemoval == other.customRemoval &&
            deferUpdate == other.deferUpdate &&
            display == other.display &&
            eq(inputs, other.inputs) &&
            eq(outputs, other.outputs) &&
            eq(parameters, other.parameters) &&
            range == other.range &&
            shortName == other.shortName &&
            type == other.type &&
            overlay == other.overlay &&
            underlay == other.underlay &&
            eq(yAxis, other.yAxis) &&
            signalIQExclude == other.signalIQExclude &&
            originalName == other.originalName &&
            uniqueId == other.uniqueId &&
            nameParams == other.nameParams &&
            studyName == other.studyName &&
            fullName == other.fullName;
  }
}
