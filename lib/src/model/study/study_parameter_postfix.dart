/// A set of postfixes supported by the library
enum StudyParameterPostfix {
  enabled('Enabled'),
  value('Value'),
  color('Color');

  final String raw;
  const StudyParameterPostfix(this.raw);
}
