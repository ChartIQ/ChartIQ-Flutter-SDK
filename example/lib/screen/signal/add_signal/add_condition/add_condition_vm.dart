import 'package:chart_iq/chart_iq.dart';
import 'package:example/common/const/const.dart';
import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/data/model/condition_item.dart';
import 'package:example/data/model/option_item_model.dart';
import 'package:example/data/model/picker_color.dart';
import 'package:example/screen/signal/signal_extensions.dart';
import 'package:example/screen/studies/utils/study_extension.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddConditionVM extends ChangeNotifier {
  late List<OptionItemModel> hardcodedIndicator2Values = [
    const OptionItemModel(title: 'Value', isChecked: false),
    OptionItemModel(
      title: 'Open',
      prettyTitle: context.translate(RemoteLocaleKeys.open),
      isChecked: false,
    ),
    OptionItemModel(
      title: 'High',
      prettyTitle: context.translate(RemoteLocaleKeys.high),
      isChecked: false,
    ),
    OptionItemModel(
      title: 'Low',
      prettyTitle: context.translate(RemoteLocaleKeys.low),
      isChecked: false,
    ),
    OptionItemModel(
      title: 'Close',
      prettyTitle: context.translate(RemoteLocaleKeys.close),
      isChecked: false,
    ),
  ];

  static const kDefaultAutoColor = PickerColor('auto');
  static const _kDefaultTagMarkValue = 'X';

  AddConditionVM({
    required this.chartIQController,
    required this.study,
    required this.isEdit,
    required this.context,
    required this.showAppearance,
    this.condition,
  }) : assert(isEdit ? condition != null : true) {
    _init();
  }

  final ChartIQController chartIQController;
  final Study study;
  final bool isEdit;
  final bool showAppearance;
  final BuildContext context;

  ConditionItem? condition;

  ChartAggregationType? _aggregationType;

  bool get isAttentionMessageVisible =>
      SignalMarkerType.fromString(selectedMarkerType.title) ==
          SignalMarkerType.paintbar &&
      (_aggregationType == ChartAggregationType.kagi ||
          _aggregationType == ChartAggregationType.pAndF);

  List<OptionItemModel> operators = SignalOperator.values
      .map(
        (e) => OptionItemModel(
          prettyTitle: _getItemPrettyTitle(e.value),
          title: e.value,
          isChecked: false,
        ),
      )
      .toList();

  OptionItemModel? get selectedOperator => operators.firstWhereOrNull(
        (e) => e.isChecked,
      );

  SignalOperator? get selectedOperatorValue =>
      SignalOperator.values.firstWhereOrNull(
        (e) => e.value == selectedOperator?.title,
      );

  List<OptionItemModel> sizes = SignalSize.values
      .map(
        (e) => OptionItemModel(
          prettyTitle: _getItemPrettyTitle(e.value),
          title: e.value,
          isChecked: e == SignalSize.M,
        ),
      )
      .toList();

  OptionItemModel get selectedSize => sizes.firstWhere(
        (e) => e.isChecked,
      );

  List<OptionItemModel> positions = SignalPosition.values
      .map(
        (e) => OptionItemModel(
          prettyTitle: _getPositionPrettyTitle(e),
          title: e.value,
          isChecked: e == SignalPosition.aboveCandle,
        ),
      )
      .toList();

  OptionItemModel get selectedPosition => positions.firstWhere(
        (e) => e.isChecked,
      );

  List<OptionItemModel> shapes = SignalShape.values
      .map(
        (e) => OptionItemModel(
          prettyTitle: _getItemPrettyTitle(e.value),
          title: e.value,
          isChecked: e == SignalShape.circle,
        ),
      )
      .toList();

  OptionItemModel get selectedShape => shapes.firstWhere(
        (e) => e.isChecked,
      );

  List<OptionItemModel> markerTypes = SignalMarkerType.values
      .map(
        (e) => OptionItemModel(
          prettyTitle: e.getPrettyTitle(),
          title: e.value,
          isChecked: e == SignalMarkerType.marker,
        ),
      )
      .toList();

  OptionItemModel get selectedMarkerType => markerTypes.firstWhere(
        (e) => e.isChecked,
      );

  bool get showAdditionalAppearanceSettings =>
      SignalMarkerType.fromString(selectedMarkerType.title) !=
      SignalMarkerType.paintbar;

  String? valueField = '0.0';

  bool get showValueField =>
      !(selectedOperatorValue?.isNonValueItem ?? true) &&
      selectedIndicator2?.toLowerCase() ==
          hardcodedIndicator2Values[0].title.toLowerCase();

  get isSaveAvailable {
    if (selectedOperatorValue?.isNonValueItem ?? false) return true;

    return selectedOperator != null &&
        (!showValueField || (valueField?.isNotEmpty ?? false));
  }

  String tagMarkValue = _kDefaultTagMarkValue;

  PickerColor? userSelectedColor, defaultSelectedColor;

  List<OptionItemModel>? indicators1, indicators2;

  OptionItemModel? get selectedIndicator1 => indicators1?.firstWhereOrNull(
        (e) => e.isChecked,
      );

  String? selectedIndicator2;

  bool get showIndicator2 =>
      selectedIndicator1 != null &&
      selectedOperatorValue?.isNonValueItem == false;

  void _init() {
    indicators1 = study.outputs?.entries.mapIndexed((e, i) {
      return OptionItemModel(
        title: e.key,
        prettyTitle: StudyExtension.splitName(e.key)[0],
        isChecked: i == 0,
      );
    }).toList();

    if (indicators1 != null && indicators1!.isNotEmpty) {
      _reassembleIndicator2();
    }

    if (isEdit) {
      _setConditionParameters(condition!);
    } else {
      _checkColor();
      notifyListeners();
    }
    _getChartAggregationType();
  }

  void onSelect1Indicator(String title, [bool updateUI = true]) {
    indicators1 = _changeOptionListSelectedValueNullable(indicators1, title);

    _reassembleIndicator2(
      autoSelect: selectedIndicator2 == selectedIndicator1?.title,
    );

    if (updateUI) {
      _checkColor();
      notifyListeners();
    }
  }

  void onSelect2Indicator(String title, [bool updateUI = true]) {
    selectedIndicator2 = title;
    indicators2 = _changeOptionListSelectedValueNullable(indicators2, title);

    if (updateUI) notifyListeners();
  }

  void onOperatorSelected(String operator, [bool updateUI = true]) {
    operators = _changeOptionListSelectedValue(operators, operator);

    if (updateUI) notifyListeners();
  }

  void onMarkerTypeSelected(String type, [bool updateUI = true]) {
    markerTypes = _changeOptionListSelectedValue(markerTypes, type);

    if (updateUI) notifyListeners();
  }

  void onShapeSelected(String shape, [bool updateUI = true]) {
    shapes = _changeOptionListSelectedValue(shapes, shape);
    if (updateUI) notifyListeners();
  }

  void onSizeSelected(String size, [bool updateUI = true]) {
    sizes = _changeOptionListSelectedValue(sizes, size);
    if (updateUI) notifyListeners();
  }

  void onPositionSelected(String position, [bool updateUI = true]) {
    positions = _changeOptionListSelectedValue(positions, position);
    if (updateUI) notifyListeners();
  }

  void onTagMarkChanged(String? value, [bool updateUI = true]) {
    tagMarkValue = value ?? _kDefaultTagMarkValue;
    if (updateUI) notifyListeners();
  }

  void onColorSelected(PickerColor color, [bool updateUI = true]) {
    userSelectedColor = color;
    if (updateUI) notifyListeners();
  }

  void onValueFieldChanged(String? value, [bool updateUI = true]) {
    valueField = double.tryParse(value ?? '0.0')?.toString() ?? '0.0';
    if (updateUI) notifyListeners();
  }

  ConditionItem getNewCondition() {
    final color =
        userSelectedColor ?? defaultSelectedColor ?? kDefaultAutoColor;

    String? rightIndicator;
    if (showIndicator2) {
      rightIndicator = showValueField ? valueField : selectedIndicator2;
    }

    return ConditionItem(
      title: '',
      description: '',
      uuid: condition?.uuid ?? const Uuid().v4(),
      displayColor: color,
      condition: Condition(
        leftIndicator: selectedIndicator1!.title,
        rightIndicator: rightIndicator ?? '',
        signalOperator: selectedOperatorValue!,
        markerOption: MarkerOption(
          type: SignalMarkerType.fromString(selectedMarkerType.title),
          color: userSelectedColor?.value,
          signalPosition: SignalPosition.fromString(selectedPosition.title),
          signalShape: SignalShape.fromString(selectedShape.title),
          signalSize: SignalSize.values.firstWhere(
            (element) => element.value == selectedSize.title,
          ),
          label: tagMarkValue,
        ),
      ),
    );
  }

  void _setConditionParameters(ConditionItem item) {
    onSelect1Indicator(item.condition.leftIndicator);

    final indicatorNumber = double.tryParse(item.condition.rightIndicator);
    if (indicatorNumber != null) {
      onValueFieldChanged(indicatorNumber.toString(), false);
      onSelect2Indicator('value', false);
    } else {
      onSelect2Indicator(item.condition.rightIndicator, false);
    }

    onOperatorSelected(item.condition.signalOperator.value, false);
    onMarkerTypeSelected(item.condition.markerOption.type.value, false);
    onShapeSelected(item.condition.markerOption.signalShape.value, false);
    onSizeSelected(item.condition.markerOption.signalSize.value, false);
    onPositionSelected(
      item.condition.markerOption.signalPosition.value,
      false,
    );
    final tagMark = item.condition.markerOption.label;
    onTagMarkChanged(
        tagMark != null && tagMark.isNotEmpty ? tagMark : _kDefaultTagMarkValue,
        false);
    if (item.condition.markerOption.color != null) {
      onColorSelected(
        PickerColor(item.condition.markerOption.color!),
        false,
      );
    }
  }

  List<OptionItemModel> _changeOptionListSelectedValue(
    List<OptionItemModel> list,
    String titleToToggle,
  ) =>
      list
          .map(
            (e) => e.copyWith(
              isChecked: e.title.toLowerCase() == titleToToggle.toLowerCase(),
            ),
          )
          .toList();

  List<OptionItemModel>? _changeOptionListSelectedValueNullable(
    List<OptionItemModel>? list,
    String titleToToggle,
  ) =>
      list
          ?.map(
            (e) => e.copyWith(
              isChecked: e.title.toLowerCase() == titleToToggle.toLowerCase(),
            ),
          )
          .toList();

  void _reassembleIndicator2({bool autoSelect = true}) {
    indicators2 = indicators1?.where((e) => !e.isChecked).toList()
      ?..addAll(hardcodedIndicator2Values);

    if (autoSelect) {
      selectedIndicator2 = indicators2![0].title;
      indicators2 = indicators2
          ?.mapIndexed((e, i) => e.copyWith(isChecked: i == 0))
          .toList();
    } else {
      indicators2 = _changeOptionListSelectedValueNullable(
        indicators2,
        selectedIndicator2!,
      );
    }
  }

  Future<void> _getChartAggregationType() async {
    _aggregationType = await chartIQController.getChartAggregationType();
    notifyListeners();
  }

  Future<void> _checkColor() async {
    final parameters = await chartIQController.study
        .getStudyParameters(study, StudyParameterType.outputs);

    final colorParameters = parameters
        .map((element) => element is StudyParameterColor ? element : null)
        .toList();

    if (colorParameters.isEmpty) return;

    final color = colorParameters
            .firstWhereOrNull(
              (element) =>
                  element?.name ==
                  selectedIndicator1?.title
                      .split(AppConst.kZeroWidthNonJoiner)
                      .first
                      .trim(),
            )
            ?.value ??
        colorParameters.first?.value;
    if (color != null) {
      defaultSelectedColor = PickerColor(color);
      notifyListeners();
    }
  }

  static String _getItemPrettyTitle(String title) =>
      title.replaceAll('_', ' ').capitalizeAll();

  static String _getPositionPrettyTitle(SignalPosition position) {
    late final String title;
    switch (position) {
      case SignalPosition.aboveCandle:
        title = 'above_line';
        break;
      case SignalPosition.belowCandle:
        title = 'below_line';
        break;
      case SignalPosition.onCandle:
        title = 'on_line';
        break;
    }
    return _getItemPrettyTitle(title);
  }
}
