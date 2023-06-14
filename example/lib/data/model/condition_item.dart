import 'package:chartiq_flutter_sdk/chartiq_flutter_sdk.dart';
import 'package:example/data/model/picker_color.dart';

class ConditionItem {
  final Condition condition;
  final String title, description, uuid;
  final PickerColor displayColor;

  ConditionItem({
    required this.condition,
    required this.title,
    required this.description,
    required this.uuid,
    required this.displayColor,
  });
}
