/// An enumeration of available chart layers
enum ChartLayer {
  /// A chart layer for a top
  top('top'),

  /// A chart layer for a up
  up('up'),

  /// A chart layer for a back
  back('back'),

  /// A chart layer for a bottom
  bottom('bottom');

  final String value;

  const ChartLayer(this.value);
}
