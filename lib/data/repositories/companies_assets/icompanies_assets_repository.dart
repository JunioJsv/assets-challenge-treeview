import 'package:assets_challenge/data/models/companies_assets/asset.dart';
import 'package:assets_challenge/data/models/companies_assets/company.dart';
import 'package:assets_challenge/data/models/companies_assets/location.dart';

abstract class ICompaniesAssetsRepository {
  Future<List<Company>> getCompanies();
  Future<List<Location>> getCompanyLocations(String companyId);
  Future<List<Asset>> getCompanyAssets(String companyId);
}