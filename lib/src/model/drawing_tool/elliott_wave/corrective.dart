/// An enumeration of available correctives
enum WaveCorrective {
  abcCapital("A B C"),
  abcNormal("a b c"),
  wxyCapital("W X Y"),
  wxyNormal("w x y"),
  none("- - -");

  final String value;

  const WaveCorrective(this.value);
}
