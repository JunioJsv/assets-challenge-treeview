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

  Widget? get trailing;

  CompanyAssetTreeNode cloneWithoutChildren();

  CompanyAssetTreeNode({required this.id, required this.name, this.parentId});
}

class LocationTreeNode extends CompanyAssetTreeNode {
  LocationTreeNode({required super.id, required super.name, super.parentId});

  @override
  Widget get icon => SvgPicture.asset("assets/svg/location.svg");

  @override
  Widget? get trailing => null;

  @override
  CompanyAssetTreeNode cloneWithoutChildren() {
    return LocationTreeNode(id: id, name: name, parentId: parentId);
  }
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

  @override
  Widget? get trailing => null;

  @override
  CompanyAssetTreeNode cloneWithoutChildren() {
    return AssetTreeNode(
      id: id,
      name: name,
      parentId: parentId,
      locationId: locationId,
    );
  }
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

  @override
  Widget? get trailing {
    final asset = sensorStatus == SensorStatus.alert
        ? "assets/svg/danger_ellipse.svg"
        : sensorType == SensorType.energy
        ? "assets/svg/bolt.svg"
        : null;

    if (asset != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 8),
        child: SvgPicture.asset(asset),
      );
    }

    return null;
  }

  @override
  CompanyAssetTreeNode cloneWithoutChildren() {
    return ComponentTreeNode(
      id: id,
      name: name,
      parentId: parentId,
      locationId: locationId,
      sensorType: sensorType,
      sensorStatus: sensorStatus,
    );
  }
}
