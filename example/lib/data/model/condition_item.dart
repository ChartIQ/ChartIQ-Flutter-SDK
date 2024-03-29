import 'package:chart_iq/chart_iq.dart';
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
