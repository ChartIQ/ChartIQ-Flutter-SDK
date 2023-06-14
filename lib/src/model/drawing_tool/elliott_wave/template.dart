/// An enumeration of available templates
enum WaveTemplate {
  grandSupercycle("Grand Supercycle"),
  supercycle("Supercycle"),
  cycle("Cycle"),
  primary("Primary"),
  intermediate("Intermediate"),
  minor("Minor"),
  minute("Minute"),
  minuette("Minuette"),
  subMinuette("Sub-Minuette"),
  custom("Custom");

  final String value;

  const WaveTemplate(this.value);
}
