
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum FontSize {
  size8("8px"),
  size10("10px"),
  size12("12px"),
  size13("13px"),
  size14("14px"),
  size16("16px"),
  size20("20px"),
  size28("28px"),
  size36("36px"),
  size48("48px"),
  size64("64px");

  final String value;
  const FontSize(this.value);
}