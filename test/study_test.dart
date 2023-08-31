import 'package:chart_iq/chart_iq.dart';
import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';

import 'raw_study_info.dart';

void main() {
  final eq = const DeepCollectionEquality().equals;

  group('Study', () {
    test('==(equals) operator override works properly', () {
      final study1 = Study.fromJson(studyJson);
      final study2 = Study.fromJson(studyJson);

      expect(study1 == study2, isTrue);
    });

    test('Properly parsed from json and filling values', () {
      final study = Study.fromJson(studyJson);

      expect(study.shortName == shortName, isTrue);
      expect(study.name == name, isTrue);
      expect(study.centerLine == centerLine, isTrue);
      expect(study.display == display, isTrue);
      expect(study.range == range, isTrue);
      expect(study.type == studyType, isTrue);
      expect(study.signalIQExclude == signalIQExclude, isTrue);
      expect(study.customRemoval == customRemoval, isTrue);
      expect(study.deferUpdate == deferUpdate, isTrue);
      expect(study.overlay == overlay, isTrue);
      expect(study.underlay == underlay, isTrue);
      expect(eq(study.yAxis, yAxis), isTrue);
      expect(eq(study.attributes, attributes), isTrue);
      expect(eq(study.inputs, inputs), isTrue);
      expect(eq(study.outputs, outputs), isTrue);
      expect(eq(study.parameters, parameters), isTrue);
    });
  });

  const Map<String, dynamic> studySimplifiedJson = {
    'studyName': shortName,
    'type': studyType,
    'outputs': outputs,
  };

  group('Study simplified', () {
    test('==(equals) operator work properly', () {
      final study1 = StudySimplified.fromJson(studySimplifiedJson);
      final study2 = StudySimplified.fromJson(studySimplifiedJson);

      expect(study1 == study2, isTrue);
    });

    test('Properly parsed from json and filling values', () {
      final study = StudySimplified.fromJson(studySimplifiedJson);

      expect(study.studyName == shortName, isTrue);
      expect(study.type == studyType, isTrue);
      expect(eq(study.outputs, outputs), isTrue);
    });
  });
}
