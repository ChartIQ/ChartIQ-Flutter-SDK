import 'dart:convert';
import 'dart:io';

import 'package:chart_iq/src/model/study/chart_iq_study.dart';
import 'package:chart_iq/src/model/study/study.dart';
import 'package:chart_iq/src/model/study/study_parameter_type.dart';
import 'package:chart_iq/src/model/study/study_simplified.dart';
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
    return channel
        .invokeMethod('addStudy', [jsonEncode(study.toJson()), forClone]);
  }

  @override
  Future<List<StudyParameter>> getStudyParameters(
      Study study, StudyParameterType type) async {
    final res = await channel.invokeMethod(
        'getStudyParameters', [jsonEncode(study.toJson()), type.value]);

    final List<dynamic> json = jsonDecode(res);

    final List<StudyParameterWrapper> list =
        json.map((e) => StudyParameterWrapper.fromJson(e)).toList();
    List<StudyParameter> result = [];
    for (var element in list) {
      if (element.type.toLowerCase() == "text") {
        result.add(StudyParameterText.fromJson(element.value));
      }
      if (element.type.toLowerCase() == "number") {
        result.add(StudyParameterNumber.fromJson(element.value));
      }
      if (element.type.toLowerCase() == "color") {
        result.add(StudyParameterColor.fromJson(element.value));
      }
      if (element.type.toLowerCase() == "textcolor") {
        result.add(StudyParameterTextColor.fromJson(element.value));
      }
      if (element.type.toLowerCase() == "checkbox") {
        result.add(StudyParameterCheckbox.fromJson(element.value));
      }
      if (element.type.toLowerCase() == "select") {
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
    await channel.invokeMethod('setStudyParameter',
        [jsonEncode(study.toJson()), jsonEncode(parameter.toJson())]);
  }

  @override
  Future<dynamic> setStudyParameters(
      Study study, List<StudyParameterModel> parameters) async {
    final res = await channel.invokeMethod('setStudyParameters', [
      jsonEncode(study.toJson()),
      jsonEncode(parameters.map((e) => e.toJson()).toList())
    ]);
    if (Platform.isAndroid) {
      return StudySimplified.fromJson(jsonDecode(res));
    } else {
      return Study.fromJson(jsonDecode(res));
    }
  }
}
