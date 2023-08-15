import 'dart:io';

/// An enumeration of available drawing tools
enum DrawingTool {
  /// A drawing tool for a annotation
  annotation('annotation', 'annotation'),

  /// A drawing tool for a arrow
  arrow('arrow', 'arrow'),

  /// A drawing tool for a averageLine
  averageLine('average', 'average'),

  /// A drawing tool for a callout
  callout('callout', 'callout'),

  /// A drawing tool for a channel
  channel('channel', 'channel'),

  /// A drawing tool for a check
  check('check', 'check'),

  /// A drawing tool for a continuousLine
  continuousLine('continuous', 'continuous'),

  /// A drawing tool for a cross
  cross('xcross', 'xcross'),

  /// A drawing tool for a crossLine
  crossLine('crossline', 'crossline'),

  /// A drawing tool for a doodle
  doodle('freeform', 'freeform'),

  /// A drawing tool for a elliotWave
  elliotWave('elliottwave', 'elliottwave'),

  /// A drawing tool for a ellipse
  ellipse('ellipse', 'ellipse'),

  /// A drawing tool for a fibArc
  fibArc('fibarc', 'fibarc'),

  /// A drawing tool for a fibFan
  fibFan('fibfan', 'fibfan'),

  /// A drawing tool for a fibProjection
  fibProjection('fibprojection', 'fibprojection'),

  /// A drawing tool for a fibRetracement
  fibRetracement('retracement', 'fibonacci'),

  /// A drawing tool for a fibTimeZone
  fibTimeZone('fibtimezone', 'fibtimezone'),

  /// A drawing tool for a focus
  focus('focusarrow', 'focusarrow'),

  /// A drawing tool for a gannFan
  gannFan('gannfan', 'gannfan'),

  /// A drawing tool for a gartley
  gartley('gartley', 'gartley'),

  /// A drawing tool for a heart
  heart('heart', 'heart'),

  /// A drawing tool for a horizontalLine
  horizontalLine('horizontal', 'horizontal'),

  /// A drawing tool for a line
  line('line', 'line'),

  /// A drawing tool for a measure
  measure('measure', 'measure'),

  /// A drawing tool for a noTool
  noTool('', ''),

  /// A drawing tool for a pitchfork
  pitchfork('pitchfork', 'pitchfork'),

  /// A drawing tool for a quadrantLines
  quadrantLines('quadrant', 'quadrant'),

  /// A drawing tool for a ray
  ray('ray', 'ray'),

  /// A drawing tool for a rectangle
  rectangle('rectangle', 'rectangle'),

  /// A drawing tool for a regressionLine
  regressionLine('regression', 'regression'),

  /// A drawing tool for a segment
  segment('segment', 'segment'),

  /// A drawing tool for a speedResistanceArc
  speedResistanceArc('speedarc', 'speedarc'),

  /// A drawing tool for a speedResistanceLine
  speedResistanceLine('speedline', 'speedline'),

  /// A drawing tool for a star
  star('star', 'star'),

  /// A drawing tool for a timeCycle
  timeCycle('timecycle', 'timecycle'),

  /// A drawing tool for a tironeLevels
  tironeLevels('tirone', 'tirone'),

  /// A drawing tool for a trendLine
  trendLine('trendline', 'trendline'),

  /// A drawing tool for a verticalLine
  verticalLine('vertical', 'vertical'),

  /// A drawing tool for a volumeProfile
  volumeProfile('volumeprofile', 'volumeprofile'),

  /// none
  none(null, null);

  final String? _value, _iosValue;

  const DrawingTool(this._value, this._iosValue);
  String? get value => Platform.isIOS ? _iosValue: _value;
}