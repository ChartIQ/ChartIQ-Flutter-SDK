import 'package:chart_iq/chart_iq.dart';
import 'package:example/common/const/const.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/data/model/condition_item.dart';
import 'package:example/data/model/picker_color.dart';
import 'package:example/screen/signal/signal_extensions.dart';
import 'package:example/screen/signal/signal_study_info_model.dart';
import 'package:example/screen/studies/utils/study_extension.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddSignalVM extends ChangeNotifier {
  static const _kDefaultColorString = '#FF0000';

  AddSignalVM({
    required this.chartIQController,
    this.signal,
  }) {
    if (signal != null) {
      nameValue = signal?.name;
      descriptionValue = signal?.description;
      _selectedStudy = signal?.study;
      _selectedJoiner = signal?.joiner ?? SignalJoiner.or;
      _rawConditions = signal?.conditions ?? [];
      isEditMode = true;
      _processRawConditions();
    } else {
      isEditMode = false;
    }
  }

  Signal? signal;
  late final bool isEditMode;

  final ChartIQController chartIQController;

  SignalJoiner _selectedJoiner = SignalJoiner.or;

  SignalJoiner get selectedJoiner => _selectedJoiner;

  set selectedJoiner(SignalJoiner value) {
    _selectedJoiner = value;
    notifyListeners();
  }

  Study? _selectedStudy;

  set selectedStudy(Study? study) {
    _selectedStudy = study;
    notifyListeners();
  }

  bool canShowAppearanceForCondition(ConditionItem? condition) {
    if (selectedJoiner == SignalJoiner.or || conditions.isEmpty) {
      return true;
    } else {
      return condition == conditions.first;
    }
  }

  Study? get selectedStudy => _selectedStudy;

  List<ConditionItem> conditions = [];
  List<Condition> _rawConditions = [];

  bool get isSaveAvailable =>
      _selectedStudy != null &&
      (nameValue != null && nameValue!.isNotEmpty) &&
      conditions.isNotEmpty;

  String? nameValue, descriptionValue;

  set name(String? value) {
    nameValue = value;
    notifyListeners();
  }

  set description(String? value) {
    descriptionValue = value;
    notifyListeners();
  }

  void addCondition(ConditionItem condition) {
    conditions.add(condition);
    _processConditionsItems();
  }

  void removeCondition(int index) {
    conditions.removeAt(index);
    _processConditionsItems();
  }

  void updateCondition(ConditionItem condition) {
    final index = conditions.indexWhere((e) => e.uuid == condition.uuid);
    conditions[index] = condition;
    _processConditionsItems();
  }

  void onJoinerChanged(SignalJoiner joiner) {
    _selectedJoiner = joiner;
    notifyListeners();
  }

  Future<void> addSignal() async {
    signal = Signal(
      uniqueId: signal?.uniqueId ?? '',
      name: nameValue!,
      description: descriptionValue ?? '',
      study: selectedStudy!,
      conditions: conditions.map((e) => e.condition).toList(),
      joiner: selectedJoiner,
      disabled: signal?.disabled ?? false,
    );
    await chartIQController.signal.saveSignal(
      signal!,
      isEditMode,
    );
  }

  void clearConditions() {
    conditions.clear();
    notifyListeners();
  }

  void onStudyEdited(dynamic simplified) async {
    final previousStudyShortName = selectedStudy?.shortName;
    if (simplified is StudySimplified) {
      selectedStudy = selectedStudy?.copyWithSimplified(simplified);
      conditions = await Future.wait(
        conditions.map((e) async {
          final f = ConditionItem(
            condition: e.condition.copyWithIndicators(
              leftIndicator: e.condition.leftIndicator.replaceAll(
                previousStudyShortName!,
                simplified.studyName,
              ),
              rightIndicator: e.condition.rightIndicator.replaceAll(
                previousStudyShortName,
                simplified.studyName,
              ),
            ),
            title: e.title,
            description: e.description,
            uuid: e.uuid,
            displayColor: await _checkDisplayColor(e.condition),
          );
          return f;
        }).toList(),
      );
    } else if (simplified is Study) {
      selectedStudy = simplified;
      conditions = await Future.wait(
        conditions.map((e) async {
          var leftIndicator = "";
          var rightIndicator = "";
          simplified.outputs?.forEach((key, value) {
            if (value is String) {
              if (e.condition.leftIndicator.contains(value)) {
                leftIndicator = key;
              }
              if (e.condition.rightIndicator.contains(value)) {
                rightIndicator = key;
              }
            }
          });
          final f = ConditionItem(
            condition: e.condition.copyWithIndicators(
              leftIndicator: leftIndicator,
              rightIndicator: rightIndicator,
            ),
            title: e.title,
            description: e.description,
            uuid: e.uuid,
            displayColor: await _checkDisplayColor(e.condition),
          );
          return f;
        }).toList(),
      );
    }
    SignalStudyInfoModel.instance.studies.add(selectedStudy!);
    notifyListeners();
  }

  void _processConditionsItems() async {
    conditions = await Future.wait(
      conditions.mapIndexed((e, i) async {
        String rightIndicator =
            double.tryParse(e.condition.rightIndicator)?.toString() ??
                StudyExtension.splitName(e.condition.rightIndicator)[0];

        final description =
            '${StudyExtension.splitName(e.condition.leftIndicator)[0]} '
            '${e.condition.signalOperator.value.replaceAll('_', ' ').capitalize()} '
            '$rightIndicator';

        return ConditionItem(
          condition: e.condition,
          title: "${i + 1} Condition",
          description: description,
          uuid: e.uuid,
          displayColor: await _checkDisplayColor(e.condition),
        );
      }).toList(),
    );

    notifyListeners();
  }

  void _processRawConditions() async {
    conditions = await Future.wait(
      _rawConditions.mapIndexed((e, i) async {
        return ConditionItem(
          condition: e,
          title: '',
          description: '',
          uuid: const Uuid().v4(),
          displayColor: await _checkDisplayColor(e),
        );
      }).toList(),
    );

    _processConditionsItems();
  }

  Future<PickerColor> _checkDisplayColor(Condition condition) async {
    if (condition.markerOption.color != null) {
      return PickerColor(condition.markerOption.color!);
    }

    final parameters = await chartIQController.study
        .getStudyParameters(_selectedStudy!, StudyParameterType.outputs);

    final colorParameters = parameters
        .map((element) => element is StudyParameterColor ? element : null)
        .toList();

    if (colorParameters.isEmpty) return const PickerColor(_kDefaultColorString);

    final color = colorParameters
            .firstWhereOrNull(
              (element) =>
                  element?.name ==
                  condition.leftIndicator
                      .split(AppConst.kZeroWidthNonJoiner)
                      .first
                      .trim(),
            )
            ?.value ??
        colorParameters.first?.value;
    if (color != null) {
      return PickerColor(color);
    }
    return const PickerColor(_kDefaultColorString);
  }
}
