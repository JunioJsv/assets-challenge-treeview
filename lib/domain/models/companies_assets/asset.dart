import 'package:assets_challenge/domain/models/companies_assets/sensor_status.dart';
import 'package:assets_challenge/domain/models/companies_assets/sensor_type.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'asset.g.dart';
@JsonSerializable()
class Asset extends Equatable {
  final String id;
  final String name;

  final String? locationId;

  final String? parentId;

  final SensorType? sensorType;

  final SensorStatus? status;

  const Asset({
    required this.id,
    required this.name,
    this.locationId,
    this.parentId,
    this.sensorType,
    this.status,
  });

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
  Map<String, dynamic> toJson() => _$AssetToJson(this);

  @override
  List<Object?> get props => [id, name, locationId, parentId, sensorType, status];
}