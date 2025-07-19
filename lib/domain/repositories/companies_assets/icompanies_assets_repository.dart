import 'package:assets_challenge/domain/models/companies_assets/company.dart';
import 'package:assets_challenge/domain/models/companies_assets/company_asset_tree_node.dart';

abstract class ICompaniesAssetsRepository {
  Future<List<Company>> getCompanies();

  Future<List<LocationTreeNode>> getCompanyLocations(String companyId);

  Future<List<CompanyAssetTreeNode>> getCompanyAssets(String companyId);
}
