import 'package:assets_challenge/constants.dart';
import 'package:assets_challenge/data/models/companies_assets/asset.dart';
import 'package:assets_challenge/data/models/companies_assets/company.dart'
    as data;
import 'package:assets_challenge/domain/models/companies_assets/company.dart'
    as domain;

import 'package:assets_challenge/data/models/companies_assets/location.dart';
import 'package:assets_challenge/domain/models/companies_assets/company_asset_tree_node.dart';
import 'package:assets_challenge/domain/repositories/companies_assets/icompanies_assets_repository.dart';
import 'package:assets_challenge/utils/ihttp_client.dart';
import 'package:assets_challenge/utils/json_utils.dart';

class CompaniesAssetsRepository implements ICompaniesAssetsRepository {
  final IHttpClient _client;

  CompaniesAssetsRepository(this._client);

  @override
  Future<List<domain.Company>> getCompanies() async {
    final response = await _client.get("$baseApi/companies");
    final list = await jsonToList(response);
    final companies = list.map((json) {
      final company = data.Company.fromJson((json as Map).cast());

      return company.toDomain();
    }).toList();

    return companies;
  }

  @override
  Future<List<CompanyAssetTreeNode>> getCompanyAssets(String companyId) async {
    final response = await _client.get("$baseApi/companies/$companyId/assets");
    final list = await jsonToList(response);
    final assets = list.map((json) {
      final asset = Asset.fromJson((json as Map).cast());
      return asset.toTreeNode();
    }).toList();

    return assets;
  }

  @override
  Future<List<LocationTreeNode>> getCompanyLocations(String companyId) async {
    final response = await _client.get(
      "$baseApi/companies/$companyId/locations",
    );
    final list = await jsonToList(response);
    final locations = list.map((json) {
      final location = Location.fromJson((json as Map).cast());
      return location.toTreeNode();
    }).toList();

    return locations;
  }
}
