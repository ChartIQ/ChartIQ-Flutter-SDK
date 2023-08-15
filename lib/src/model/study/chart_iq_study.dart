import 'package:chart_iq/chartiq_flutter_sdk.dart';

abstract class ChartIQStudy {
  /// Gets a list of available studies [Study]
  Future<List<Study>> getStudyList();

  /// Gets a list of active/selected studies [Study]
  Future<List<Study>> getActiveStudies();

  /// Removes a selected study [Study] from the list of active studies
  Future<void> removeStudy(Study study);

  /// Adds a study [Study] to a list of active studies
  /// [study] A study to add/clone
  /// forClone If true, clones a selected active study and adds it to the list of active studies with changed parameters.
  /// If false, adds a new study with default parameters to a list of active studies
  /// if [study] is from  [getStudyList] use `false`,
  /// if [study] is from [getActiveStudies] use `true`
  Future<void> addStudy(Study study, bool forClone);

  /// Modifies a selected study [Study] with a single parameter
  /// [study] A study to change
  /// [parameter] A changed parameter for selected study, [StudyParameterModel] that contains key-value to be updated
  /// To set a parameter of [StudyParameterType.Parameters] type it's [StudyParameter.name] should be transformed to
  /// [StudyParameter.name] + [StudyParameter.StudyParameterNamePostfix]
  ///
  /// For example, for the color parameter with a original name `line` a generated name should be `lineColor`
  Future<void> setStudyParameter(
      Study study, StudyParameterModel parameter);

  /// Modifies a selected study [Study] with a list of parameters
  /// [study] A study to change
  /// [parameters] A list of changed parameters for selected study, [StudyParameterModel] that contains key-value to be updated
  Future<dynamic> setStudyParameters(
      Study study, List<StudyParameterModel> parameters);

  /// Gets a list of parameters [StudyParameter] of a selected study [Study]
  /// [study] A selected study [Study]
  /// [type] A type [StudyParameterType] of parameters to get
  Future<List<StudyParameter>> getStudyParameters(
      Study study, StudyParameterType type);
}
