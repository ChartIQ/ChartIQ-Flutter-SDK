import 'package:chart_iq/chartiq_flutter_sdk.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const fieldName = 'Buy Stops', fieldSelectedValue = '#FF0000';

  const Map<String, dynamic> studyParameterJson = {
    'fieldName': fieldName,
    'fieldSelectedValue': fieldSelectedValue,
  };

  group('Study parameter', () {
    test('Properly parsed from json and filling values', () {
      final studyParameter = StudyParameterModel.fromJson(studyParameterJson);

      expect(studyParameter.fieldName == fieldName, isTrue);
      expect(studyParameter.fieldSelectedValue == fieldSelectedValue, isTrue);
    });
  });
}
