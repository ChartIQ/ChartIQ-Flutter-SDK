/// A list of possible Chart types
enum ChartType {

  /// Like bar charts, candle charts represent OHLC except in the form of colored rectangles called ‘candles’.When the open is lower than the close, the candle is shaded green.
  ///
  /// When the open is higher than the close, the candle is shaded red.
  /// If the open and close are the same, a thin horizontal line segment is drawn at that
  /// price (this type of candle is called a "doji"). Each candle has a ‘wick’ that extends beyond the candle to
  /// indicate the high and low, respectively.
  candle("Candle"),

  /// Bar charts consist of vertical lines with a horizontal "shelves" on either side.
  ///
  /// One "bar" is created for each interval (period) on the chart. Each bar represents the OHLC (Open, High, Low, Close)
  /// for the period. The top and bottom of the vertical line represent the high and low for the period.
  /// The left shelf is the opening price while the right shelf is the closing price. The bars are a single color.
  bar("Bar"),

  /// A colored bar chart draws a bar chart with the bars colored to indicate price action
  coloredBar("Colored Bar"),

  /// A line chart consists of segments that connect at the "Close" price for each time period.
  ///
  /// The line is a single color.
  /// Any value in your data that has a null value for "Close" will result in a gap within the line.
  line("Line"),

  /// A vertex line
  vertexLine(" Line"),

  /// A variation of a 'Line' where lines are forced to connect in an indirect 'step' manner (horizontal and vertical
  /// lines only), rather than a direct line connecting the data-points. Horizontal lines will begin at the center of the bar.
  step("Step"),

  /// Mountain charts (sometimes called area charts)
  ///
  /// These are line charts with a shaded section that extends to the bottom
  /// of the chart. The result is a chart which looks like a mountain.
  mountain("Mountain"),

  /// A baseline delta chart draws a line chart that oscillates across a dotted baseline.
  ///
  /// The area above the baseline is shaded green, and the area below the baseline is shaded red.
  baseline("Baseline"),

  /// Like bar charts, candle charts represent OHLC except in the form of colored rectangles called ‘candles’.
  ///
  /// When the open is lower than the close, the candle is shaded green. When the open is higher than the close,
  /// the candle is shaded red. If the open and close are the same, a thin horizontal line segment is drawn at that
  /// price (this type of candle is called a "doji"). Each candle has a ‘wick’ that extends beyond the candle to
  /// indicate the high and low, respectively.
  hollowCandle("Hollow Candle"),

  /// A volume candle chart is a hollow candle chart where the width of a candle varies to indicate volume.
  ///
  /// Each candle’s shading and fill follow the same conventions as those in hollow candle charts. Wide candles
  /// indicate high volume, while narrow candles indicate low volume.
  volumeCandle("Volume Candle"),

  /// A colored bar chart draws a bar chart with the bars colored to indicate price action.
  coloredHLC("Colored HLC Bar"),

  /// Scatterplot draws a single 'dot' at every close and does not connect them.
  scatterPlot("Scatterplot"),

  /// Histogram charts resemble candle charts extending from the target price/amount, down to the bottom of the chart.
  /// The color is normally determined based off prior close.
  histogram("Histogram");

  final String value;

  const ChartType(this.value);
}
