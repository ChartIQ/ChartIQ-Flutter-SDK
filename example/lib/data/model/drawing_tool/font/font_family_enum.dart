import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum FontFamily {
  defaultFont('Default'),
  helvetica('Helvetica'),
  courier('Courier'),
  garamond('Garamond'),
  palatino('Palatino'),
  timesNewRoman('Times New Roman');

  final String value;
  const FontFamily(this.value);
}