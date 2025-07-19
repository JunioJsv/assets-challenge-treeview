import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:assets_challenge/domain/models/companies_assets/company.dart'
    as domain;

part 'company.g.dart';

@JsonSerializable()
class Company extends Equatable {
  final String id;
  final String name;

  const Company({required this.id, required this.name});

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);

  domain.Company toDomain() => domain.Company(id: id, name: name);

  @override
  List<Object?> get props => [id, name];
}
