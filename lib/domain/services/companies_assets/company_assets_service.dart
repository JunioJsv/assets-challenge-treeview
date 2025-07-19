import 'package:assets_challenge/domain/models/companies_assets/company_asset_tree_node.dart';
import 'package:assets_challenge/domain/repositories/companies_assets/icompanies_assets_repository.dart';
import 'package:assets_challenge/domain/services/companies_assets/icompany_assets_service.dart';

class CompanyAssetsService implements ICompanyAssetsService {
  final ICompaniesAssetsRepository repository;

  CompanyAssetsService(this.repository);

  @override
  Future<List<CompanyAssetTreeNode>> getAssetsTreeNodes(
    String companyId,
  ) async {
    final locations = await repository.getCompanyLocations(companyId);
    final assets = await repository.getCompanyAssets(companyId);

    final nodes = Map.fromEntries(
      [...locations, ...assets].map((node) {
        return MapEntry(node.id, node);
      }),
    );

    final List<CompanyAssetTreeNode> roots = [];

    for (final node in nodes.values) {
      final parentId = node.parentId;

      if (parentId != null && nodes.containsKey(node.id)) {
        nodes[parentId]!.children.add(node);
      } else {
        roots.add(node);
      }
    }

    return roots;
  }
}
