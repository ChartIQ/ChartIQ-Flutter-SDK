/// An enumeration of available drawing tools
enum DrawingTool {
  /// A drawing tool for a annotation
  annotation('annotation'),

  /// A drawing tool for a arrow
  arrow('arrow'),

  /// A drawing tool for a averageLine
  averageLine('average'),

  /// A drawing tool for a callout
  callout('callout'),

  /// A drawing tool for a channel
  channel('channel'),

  /// A drawing tool for a check
  check('check'),

  /// A drawing tool for a continuousLine
  continuousLine('continuous'),

  /// A drawing tool for a cross
  cross('xcross'),

  /// A drawing tool for a crossLine
  crossLine('crossline'),

  /// A drawing tool for a doodle
  doodle('freeform'),

  /// A drawing tool for a elliotWave
  elliotWave('elliottwave'),

  /// A drawing tool for a ellipse
  ellipse('ellipse'),

  /// A drawing tool for a fibArc
  fibArc('fibarc'),

  /// A drawing tool for a fibFan
  fibFan('fibfan'),

  /// A drawing tool for a fibProjection
  fibProjection('fibprojection'),

  /// A drawing tool for a fibRetracement
  fibRetracement('retracement'),

  /// A drawing tool for a fibTimeZone
  fibTimeZone('fibtimezone'),

  /// A drawing tool for a focus
  focus('focusarrow'),

  /// A drawing tool for a gannFan
  gannFan('gannfan'),

  /// A drawing tool for a gartley
  gartley('gartley'),

  /// A drawing tool for a heart
  heart('heart'),

  /// A drawing tool for a horizontalLine
  horizontalLine('horizontal'),

  /// A drawing tool for a line
  line('line'),

  /// A drawing tool for a measure
  measure('measure'),

  /// A drawing tool for a noTool
  noTool(''),

  /// A drawing tool for a pitchfork
  pitchfork('pitchfork'),

  /// A drawing tool for a quadrantLines
  quadrantLines('quadrant'),

  /// A drawing tool for a ray
  ray('ray'),

  /// A drawing tool for a rectangle
  rectangle('rectangle'),

  /// A drawing tool for a regressionLine
  regressionLine('regression'),

  /// A drawing tool for a segment
  segment('segment'),

  /// A drawing tool for a speedResistanceArc
  speedResistanceArc('speedarc'),

  /// A drawing tool for a speedResistanceLine
  speedResistanceLine('speedline'),

  /// A drawing tool for a star
  star('star'),

  /// A drawing tool for a timeCycle
  timeCycle('timecycle'),

  /// A drawing tool for a tironeLevels
  tironeLevels('tirone'),

  /// A drawing tool for a trendLine
  trendLine('trendline'),

  /// A drawing tool for a verticalLine
  verticalLine('vertical'),

  /// A drawing tool for a volumeProfile
  volumeProfile('volumeprofile'),

  /// none
  none(null);

  final String? value;

  const DrawingTool(this.value);
}