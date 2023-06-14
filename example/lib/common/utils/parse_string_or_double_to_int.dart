int? parseStringOrDoubleToInt(dynamic number) {
  if (number.runtimeType == String) return int.tryParse(number);
  if (number.runtimeType == double) return number.toInt();
  return null;
}
