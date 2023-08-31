/// A possible study parameter types
enum StudyParameterType {
  inputs('Inputs'),
  outputs('Outputs'),
  parameters('Parameters');

  final String value;

  const StudyParameterType(this.value);
}
