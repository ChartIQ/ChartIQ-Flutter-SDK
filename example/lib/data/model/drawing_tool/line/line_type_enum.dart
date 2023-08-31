import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum LineType {
  solid,
  dotted,
  dashed;
}
