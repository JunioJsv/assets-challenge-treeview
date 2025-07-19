import 'package:assets_challenge/data/models/companies_assets/sensor_status.dart';
import 'package:assets_challenge/data/models/companies_assets/sensor_type.dart';
import 'package:assets_challenge/domain/models/companies_assets/company_asset_tree_node.dart';
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

  @JsonKey(name: "status")
  final SensorStatus? sensorStatus;

  const Asset({
    required this.id,
    required this.name,
    this.locationId,
    this.parentId,
    this.sensorType,
    this.sensorStatus,
  });

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);

  Map<String, dynamic> toJson() => _$AssetToJson(this);

  CompanyAssetTreeNode toTreeNode() {
    final sensorType = this.sensorType;
    final isComponent = sensorType != null;
    if (isComponent) {
      return ComponentTreeNode(
        id: id,
        name: name,
        locationId: locationId,
        parentId: parentId,
        sensorType: sensorType,
        sensorStatus: sensorStatus,
      );
    } else {
      return AssetTreeNode(
        id: id,
        name: name,
        locationId: locationId,
        parentId: parentId,
      );
    }
  }

  @override
  List<Object?> get props => [
    id,
    name,
    locationId,
    parentId,
    sensorType,
    sensorStatus,
  ];
}
