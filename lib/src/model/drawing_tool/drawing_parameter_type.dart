/// An enumeration of available drawing tool parameters types
enum DrawingParameterType {
  fillColor('fillColor'),
  lineColor('color'),
  lineType('pattern'),
  lineWidth('lineWidth'),
  family('family'),
  size('size'),
  style('style'),
  weight('weight'),
  fibs('fibs'),
  showLines("showLines"),
  axisLabel("axisLabel"),
  waveTemplate("waveTemplate"),
  impulse("impulse"),
  corrective("corrective"),
  decoration("decoration"),
  active1("active1"),
  active2("active2"),
  active3("active3"),
  color1("color1"),
  color2("color2"),
  color3("color3"),
  lineWidth1("lineWidth1"),
  lineWidth2("lineWidth2"),
  lineWidth3("lineWidth3"),
  pattern1("pattern1"),
  pattern2("pattern2"),
  pattern3("pattern3"),
  priceBuckets('priceBuckets');

  final String value;

  const DrawingParameterType(this.value);
}
