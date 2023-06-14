import 'dart:convert';

import 'package:chartiq_flutter_sdk/src/model/study/chart_iq_study.dart';
import 'package:chartiq_flutter_sdk/src/model/study/study.dart';
import 'package:chartiq_flutter_sdk/src/model/study/study_parameter_type.dart';
import 'package:chartiq_flutter_sdk/src/model/study/study_simplified.dart';
import 'package:flutter/services.dart';

import 'study_parameter.dart';
import 'study_parameter_model.dart';
import 'study_parameter_wrapper.dart';

class ChartIQStudyImpl implements ChartIQStudy {
  final MethodChannel channel;

  ChartIQStudyImpl({required this.channel});

  @override
  Future<List<Study>> getStudyList() async {
    final res = await channel.invokeMethod('getStudyList');
    final List<dynamic> json = jsonDecode(res);
    return json.map((e) => Study.fromJson(e)).toList();
  }

  @override
  Future<List<Study>> getActiveStudies() async {
    final res = await channel.invokeMethod('getActiveStudies');
    final List<dynamic> json = jsonDecode(res);
    return json.map((e) => Study.fromJson(e)).toList();
  }

  @override
  Future<void> addStudy(Study study, bool forClone) {
    return channel.invokeMethod('addStudy', [jsonEncode(study.toJson()), forClone]);
  }

  @override
  Future<List<StudyParameter>> getStudyParameters(
      Study study, StudyParameterType type) async {
    final res = await channel
        .invokeMethod('getStudyParameters', [jsonEncode(study.toJson()), type.value]);
    final List<dynamic> json = jsonDecode(res);
    final List<StudyParameterWrapper> list =
        json.map((e) => StudyParameterWrapper.fromJson(e)).toList();
    List<StudyParameter> result = [];
    for (var element in list) {
      if (element.type == "Text") {
        result.add(StudyParameterText.fromJson(element.value));
      }
      if (element.type == "Number") {
        result.add(StudyParameterNumber.fromJson(element.value));
      }
      if (element.type == "Color") {
        result.add(StudyParameterColor.fromJson(element.value));
      }
      if (element.type == "TextColor") {
        result.add(StudyParameterTextColor.fromJson(element.value));
      }
      if (element.type == "Checkbox") {
        result.add(StudyParameterCheckbox.fromJson(element.value));
      }
      if (element.type == "Select") {
        result.add(StudyParameterSelect.fromJson(element.value));
      }
    }
    return result;
  }

  @override
  Future<void> removeStudy(Study study) {
    return channel.invokeMethod('removeStudy', jsonEncode(study.toJson()));
  }

  @override
  Future<void> setStudyParameter(
      Study study, StudyParameterModel parameter) async {
    await channel.invokeMethod(
        'setStudyParameter', [jsonEncode(study.toJson()), jsonEncode(parameter.toJson())]);
  }

  @override
  Future<StudySimplified> setStudyParameters(Study study, List<StudyParameterModel> parameters) async {
    final res = await channel.invokeMethod(
        'setStudyParameters', [jsonEncode(study.toJson()), jsonEncode(parameters.map((e) => e.toJson()).toList())]);
    return StudySimplified.fromJson(jsonDecode(res));
  }
}
