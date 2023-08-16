import 'dart:developer';

import 'package:chart_iq/chartiq_flutter_sdk.dart';
import 'package:example/data/model/option_item_model.dart';
import 'package:example/screen/studies/extensions/study_parameter_extension.dart';
import 'package:flutter/cupertino.dart';

class StudyParametersVM extends ChangeNotifier {
  StudyParametersVM({
    required this.chartIQController,
    required this.study,
  });

  final ChartIQController chartIQController;
  final Study study;

  List<StudyParameter> parameters = List.empty(growable: true);

  Map<String, StudyParameterModel> parametersToSave = {};

  Future<void> getStudyParameters() async {
    final futures = await Future.wait([
      chartIQController.study
          .getStudyParameters(study, StudyParameterType.inputs),
      chartIQController.study
          .getStudyParameters(study, StudyParameterType.outputs),
      chartIQController.study
          .getStudyParameters(study, StudyParameterType.parameters),
    ]);
    parameters = futures.expand((element) => element).toList();
    inspect(parameters);
    notifyListeners();
  }

  Future<dynamic> saveParameters() async {
    return await chartIQController.study.setStudyParameters(
      study,
      parametersToSave.entries.map((e) => e.value).toList(),
    );
  }

  void onCheckBoxChanged(StudyParameterCheckbox parameter, bool isChecked) {
    final parameterIndex = getParameterIndex(parameter);

    if (parameterIndex == -1) return;

    parameters[parameterIndex] = parameter.copyWithNewValue(
      value: isChecked,
    );

    final name = getParameterName(parameter, StudyParameterPostfix.enabled);
    parametersToSave[name] = StudyParameterModel(
      fieldName: getParameterName(parameter, StudyParameterPostfix.enabled),
      fieldSelectedValue: isChecked.toString(),
    );

    notifyListeners();
  }

  void onTextParamChanged(StudyParameterText parameter, String? value) {
    final parameterIndex = getParameterIndex(parameter);

    if (parameterIndex == -1) return;

    parameters[parameterIndex] = parameter.copyWithNewValue(
      value: value ?? parameter.defaultValue,
    );

    final name = getParameterName(parameter, StudyParameterPostfix.value);
    parametersToSave[name] = StudyParameterModel(
      fieldName: getParameterName(parameter, StudyParameterPostfix.value),
      fieldSelectedValue: value ?? parameter.defaultValue,
    );

    notifyListeners();
  }

  void onNumberParamChanged(StudyParameter parameter, String? value) {
    final parameterIndex = getParameterIndex(parameter);

    if (parameterIndex == -1) return;

    final localValue = (value != null && value.isNotEmpty ? value : null)?.replaceAll(",", ".");
    final localDoubleValue = double.tryParse(localValue ?? "0.0") ?? 0.0;
    if (parameters[parameterIndex] is StudyParameterNumber) {
      parameters[parameterIndex] =
          (parameters[parameterIndex] as StudyParameterNumber).copyWithNewValue(
        value: localDoubleValue,
      );
    } else if (parameters[parameterIndex] is StudyParameterTextColor) {
      parameters[parameterIndex] =
          (parameters[parameterIndex] as StudyParameterTextColor)
              .copyWithNewValue(
        value: localDoubleValue,
      );
    }

    final name = getParameterName(parameter, StudyParameterPostfix.value);
    parametersToSave[name] = StudyParameterModel(
      fieldName: getParameterName(parameter, StudyParameterPostfix.value),
      fieldSelectedValue: localDoubleValue.toString().replaceAll(",", "."),
    );

    notifyListeners();
  }

  void onColorParamChanged(StudyParameter parameter, String value) {
    final parameterIndex = getParameterIndex(parameter);

    if (parameterIndex == -1) return;

    if (parameters[parameterIndex] is StudyParameterColor) {
      parameters[parameterIndex] =
          (parameters[parameterIndex] as StudyParameterColor).copyWithNewValue(
        value: value,
      );
    } else if (parameters[parameterIndex] is StudyParameterTextColor) {
      parameters[parameterIndex] =
          (parameters[parameterIndex] as StudyParameterTextColor)
              .copyWithNewValue(
        color: value,
      );
    }

    final name = getParameterName(parameter, StudyParameterPostfix.color);
    parametersToSave[name] = StudyParameterModel(
      fieldName: name,
      fieldSelectedValue: value,
    );

    notifyListeners();
  }

  void onSelectParamChanged(
      StudyParameterSelect parameter, OptionItemModel value) {
    final parameterIndex = getParameterIndex(parameter);

    if (parameterIndex == -1) return;

    parameters[parameterIndex] = parameter.copyWithNewValue(
      value: value.title,
    );

    final name = getParameterName(parameter, StudyParameterPostfix.value);
    parametersToSave[name] = StudyParameterModel(
      fieldName: name,
      fieldSelectedValue: value.title,
    );

    notifyListeners();
  }

  void resetToDefaults() {
    for (var element in parameters) {
      if (element is StudyParameterCheckbox) {
        onCheckBoxChanged(element, element.defaultValue);
      } else if (element is StudyParameterText) {
        onTextParamChanged(element, element.defaultValue);
      } else if (element is StudyParameterNumber) {
        onNumberParamChanged(element, element.defaultValue.toString());
      } else if (element is StudyParameterColor) {
        onColorParamChanged(element, element.defaultValue);
      } else if (element is StudyParameterTextColor) {
        onNumberParamChanged(element, element.defaultValue.toString());
        onColorParamChanged(element, element.defaultColor);
      } else if (element is StudyParameterSelect) {
        onSelectParamChanged(
          element,
          OptionItemModel(
            title: element.defaultValue,
            isChecked: true,
          ),
        );
      }
    }

    notifyListeners();
  }

  String getParameterName(
    StudyParameter parameter,
    StudyParameterPostfix postfix,
  ) =>
      parameter.parameterType == StudyParameterType.parameters
          ? "${parameter.name}${postfix.raw}"
          : parameter.name;

  int getParameterIndex(StudyParameter parameter) =>
      parameters.indexWhere((e) => e.name == parameter.name);
}
