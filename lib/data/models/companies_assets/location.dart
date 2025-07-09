import 'package:assets_challenge/domain/models/company_assets/company_asset_tree_node.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location extends Equatable {
  final String id;
  final String name;
  final String? parentId;

  const Location({
    required this.id,
    required this.name,
    required this.parentId,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  CompanyAssetTreeNode toTreeNode() =>
      LocationTreeNode(id: id, name: name, parentId: parentId);

  @override
  List<Object?> get props => [id, name, parentId];
}
