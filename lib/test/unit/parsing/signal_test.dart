import 'package:chartiq_flutter_sdk/chartiq_flutter_sdk.dart';
import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';

import 'raw_study_info.dart';

void main() {
  const String type = 'MARKER';
  const String color = '#0000FF';
  const String signalShape = 'CIRCLE';
  const String signalSize = 'M';
  const String label = 'X';
  const String signalPosition = 'ABOVE_CANDLE';

  const Map<String, dynamic> markerOptionJson = {
    'type': type,
    'color': color,
    'signalShape': signalShape,
    'signalSize': signalSize,
    'label': label,
    'signalPosition': signalPosition
  };

  group('Marker options', () {
    test('Properly parsed from json and filling values', () {
      final marker = MarkerOption.fromJson(markerOptionJson);

      expect(marker.type == SignalMarkerType.marker, true);
      expect(marker.color == color, true);
      expect(marker.signalShape == SignalShape.circle, true);
      expect(marker.signalSize == SignalSize.M, true);
      expect(marker.label == label, true);
      expect(marker.signalPosition == SignalPosition.aboveCandle, true);
    });
  });

  const String leftIndicator = 'Result ‌W Acc Dist‌ (n)';
  const String rightIndicator = '0.0';
  const String signalOperator = 'EQUAL_TO';

  const Map<String, dynamic> conditionJson = {
    'leftIndicator': leftIndicator,
    'rightIndicator': rightIndicator,
    'signalOperator': signalOperator,
    'markerOption': markerOptionJson,
  };

  group('Conditions', () {
    test('Properly parsed from json and filling value', () {
      final condition = Condition.fromJson(conditionJson);
      final marker = MarkerOption.fromJson(markerOptionJson);

      expect(condition.leftIndicator == leftIndicator, true);
      expect(condition.rightIndicator == rightIndicator, true);
      expect(condition.signalOperator == SignalOperator.equalTo, true);
      expect(condition.markerOption == marker, true);
    });
  });

  const String uniqueId = 'LIBH426V161';
  const String name = 'Signal 1';
  const String joiner = 'OR';
  const String description = 'Here is a description';
  const bool disabled = false;
  List<Map<String, dynamic>> conditions =
      List.generate(5, (index) => conditionJson);

  Map<String, dynamic> signalJson = {
    'uniqueId': uniqueId,
    'name': name,
    'conditions': conditions,
    'joiner': joiner,
    'description': description,
    'disabled': disabled,
    'study': studyJson
  };
  Map<String, dynamic> signalJson2 = {
    'uniqueId': uniqueId,
    'name': name,
    'conditions': conditions.reversed,
    'joiner': joiner,
    'description': description,
    'disabled': disabled,
    'study': studyJson
  };

  group('Signal', () {
    test('==(equals) operator override works properly', () {
      final signal = Signal.fromJson(signalJson);
      final signal2 = Signal.fromJson(signalJson2);

      expect(signal == signal2, true);
    });

    test('Properly parsed from json and filling values', () {
      final signal = Signal.fromJson(signalJson);
      final study = Study.fromJson(studyJson);
      final parsedConditions =
          conditions.map((e) => Condition.fromJson(e)).toList();

      expect(signal.uniqueId == uniqueId, true);
      expect(signal.name == name, true);
      expect(
          const ListEquality().equals(
            signal.conditions,
            parsedConditions,
          ),
          true);
      expect(signal.joiner == SignalJoiner.or, isTrue);
      expect(signal.description == description, true);
      expect(signal.disabled == disabled, true);
      expect(signal.study == study, true);
    });
  });
}
