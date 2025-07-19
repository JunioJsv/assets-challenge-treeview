import 'package:assets_challenge/domain/models/companies_assets/company_asset_tree_node.dart';

abstract class ICompanyAssetsService {
  Future<List<CompanyAssetTreeNode>> getAssetsTreeNodes(String companyId);
}