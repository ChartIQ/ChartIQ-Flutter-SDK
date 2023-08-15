import 'package:chart_iq/chartiq_flutter_sdk.dart';

class StudyEntity {
  final String name;
  final Map<String, dynamic>? attributes;
  final double centerLine;
  final bool customRemoval;
  final bool deferUpdate;
  final String? display;
  final List<Map<String, dynamic>>? parsedInputs;
  final List<Map<String, dynamic>>? parsedOutputs;
  final bool overlay;
  final Map<String, dynamic>? parameters;
  final String? range;
  final String? shortName;
  final String? type;
  final bool underlay;
  final Map<String, dynamic>? yAxis;
  final bool signalIQExclude;

  StudyEntity({
    required this.name,
    required this.attributes,
    required this.centerLine,
    required this.customRemoval,
    required this.deferUpdate,
    this.display,
    this.parsedInputs,
    this.parsedOutputs,
    required this.overlay,
    this.parameters,
    this.range,
    this.shortName,
    this.type,
    required this.underlay,
    this.yAxis,
    required this.signalIQExclude,
  });

  factory StudyEntity.fromJson(Map<String, dynamic> json) {
    return StudyEntity(
      name: json['name'],
      attributes: json['attributes'],
      centerLine: json['centerLine'],
      customRemoval: json['customRemoval'],
      deferUpdate: json['deferUpdate'],
      display: json['display'],
      parsedInputs: json['parsed_inputs'],
      parsedOutputs: json['parsed_outputs'],
      overlay: json['overlay'],
      parameters: json['parameters'],
      range: json['range'],
      shortName: json['shortName'],
      type: json['type'],
      underlay: json['underlay'],
      yAxis: json['yAxis'],
      signalIQExclude: json['signalIQExclude'],
    );
  }

  Study toStudy() {
    return Study(
      name: name,
      attributes: attributes ?? {},
      centerLine: centerLine,
      customRemoval: customRemoval,
      deferUpdate: deferUpdate,
      display: display,
      inputs: parsedInputs?.isEmpty ?? true ? null : parsedInputs?.first,
      outputs: parsedOutputs?.isEmpty ?? true ? null : parsedOutputs?.first,
      overlay: overlay,
      parameters: parameters,
      range: range,
      shortName: shortName ?? name,
      type: type,
      underlay: underlay,
      yAxis: yAxis,
      signalIQExclude: signalIQExclude,
    );
  }
}
