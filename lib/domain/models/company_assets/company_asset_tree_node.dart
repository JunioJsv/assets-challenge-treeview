import 'package:assets_challenge/data/models/companies_assets/sensor_status.dart';
import 'package:assets_challenge/data/models/companies_assets/sensor_type.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

sealed class CompanyAssetTreeNode {
  final String id;
  final String name;

  final String? parentId;

  final List<CompanyAssetTreeNode> children = [];

  Widget get icon;

  CompanyAssetTreeNode({required this.id, required this.name, this.parentId});
}

class LocationTreeNode extends CompanyAssetTreeNode {
  LocationTreeNode({required super.id, required super.name, super.parentId});

  @override
  Widget get icon => SvgPicture.asset("assets/svg/location.svg");
}

class AssetTreeNode extends CompanyAssetTreeNode {
  final String? locationId;

  AssetTreeNode({
    required super.id,
    required super.name,
    super.parentId,
    this.locationId,
  });

  @override
  Widget get icon => SvgPicture.asset("assets/svg/asset.svg");
}

class ComponentTreeNode extends CompanyAssetTreeNode {
  final String? locationId;
  final SensorType sensorType;
  final SensorStatus? sensorStatus;

  ComponentTreeNode({
    required super.id,
    required super.name,
    super.parentId,
    this.locationId,
    required this.sensorType,
    this.sensorStatus,
  });

  @override
  Widget get icon => SvgPicture.asset("assets/svg/component.svg");
}
