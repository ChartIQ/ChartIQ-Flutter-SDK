int? parseStringOrDoubleToInt(dynamic number) {
  if (number.runtimeType == int) return number;
  if (number.runtimeType == String) {
    return num.tryParse(number)?.toInt();
  }
  if (number.runtimeType == double) return number.toInt();
  return null;
}
