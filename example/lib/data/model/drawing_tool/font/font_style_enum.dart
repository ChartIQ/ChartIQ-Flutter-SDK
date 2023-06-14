import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum FontStyleEnum {
  bold('bold'),
  italic('italic'),
  normal('normal');

  final String value;
  const FontStyleEnum(this.value);
}