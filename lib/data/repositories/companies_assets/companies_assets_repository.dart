import 'package:assets_challenge/constants.dart';
import 'package:assets_challenge/data/models/companies_assets/asset.dart';
import 'package:assets_challenge/data/models/companies_assets/company.dart';

import 'package:assets_challenge/data/models/companies_assets/location.dart';
import 'package:assets_challenge/utils/ihttp_client.dart';
import 'package:assets_challenge/utils/json_utils.dart';

import 'icompanies_assets_repository.dart';

class CompaniesAssetsRepository implements ICompaniesAssetsRepository {
  final IHttpClient _client;

  CompaniesAssetsRepository(this._client);

  @override
  Future<List<Company>> getCompanies() async {
    final response = await _client.get("$baseApi/companies");
    final data = await jsonToList(response);
    return data.map((json) => Company.fromJson((json as Map).cast())).toList();
  }

  @override
  Future<List<Asset>> getCompanyAssets(String companyId) async {
    final response = await _client.get("$baseApi/companies/$companyId/assets");
    final data = await jsonToList(response);
    return data.map((json) => Asset.fromJson((json as Map).cast())).toList();
  }

  @override
  Future<List<Location>> getCompanyLocations(String companyId) async {
    final response = await _client.get(
      "$baseApi/companies/$companyId/locations",
    );
    final data = await jsonToList(response);
    return data.map((json) => Location.fromJson((json as Map).cast())).toList();
  }
}
