enum ParameterEntityValueType {
  number('number'),
  select('select'),
  checkbox('checkbox'),
  text('text');

  final String value;

  const ParameterEntityValueType(this.value);
}