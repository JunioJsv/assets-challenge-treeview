import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum SensorStatus {
  operating,
  alert
}