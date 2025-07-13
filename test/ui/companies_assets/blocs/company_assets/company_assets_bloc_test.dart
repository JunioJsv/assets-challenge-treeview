import 'package:assets_challenge/data/models/companies_assets/sensor_status.dart';
import 'package:assets_challenge/data/models/companies_assets/sensor_type.dart';
import 'package:assets_challenge/domain/models/company_assets/company_asset_tree_node.dart';
import 'package:assets_challenge/utils/nullable.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:assets_challenge/ui/companies_assets/blocs/company_assets/company_assets_bloc.dart';
import 'package:assets_challenge/data/repositories/companies_assets/icompanies_assets_repository.dart';

import '../../../../data/repositories/companies_assets/mock_companies_assets_repository.dart';

void main() {
  late CompanyAssetsBloc bloc;
  late ICompaniesAssetsRepository repository;

  CompanyAssetTreeNode getNodeById(
    List<CompanyAssetTreeNode> nodes,
    String id,
  ) {
    return nodes.firstWhere((node) => node.id == id);
  }

  setUp(() {
    repository = MockCompaniesAssetsRepository();
    bloc = CompanyAssetsBloc(repository: repository);
  });

  test('Initial state is CompanyAssetsInitial', () {
    expect(bloc.state, isA<CompanyAssetsInitial>());
  });

  blocTest<CompanyAssetsBloc, CompanyAssetsState>(
    'Builds correct asset tree for companyId=1',
    build: () => bloc,
    act: (bloc) => bloc.add(GetCompanyAssetsEvent('1')),
    expect: () => [
      isA<CompanyAssetsLoadingState>(),
      isA<CompanyAssetsSuccessState>().having(
        (state) {
          final nodes = state.nodes;

          final location1 = getNodeById(nodes, '12');
          final location2 = getNodeById(nodes, '13');
          final location3 = getNodeById(location2.children, '14');

          expect(
            nodes,
            isA<List<CompanyAssetTreeNode>>()
                .having((nodes) => nodes.length, 'Nodes count', 3)
                .having(
                  (nodes) => nodes.whereType<LocationTreeNode>(),
                  'Nodes are locations',
                  hasLength(2),
                )
                .having(
                  (nodes) => nodes.whereType<ComponentTreeNode>(),
                  'Nodes are components',
                  hasLength(1),
                ),
          );

          expect(location1.children, hasLength(1));
          expect(location2.children, hasLength(2));
          expect(location3.children, hasLength(1));

          final asset1 = getNodeById(location1.children, '4');
          final asset2 = getNodeById(location2.children, '5');
          final asset3 = getNodeById(location3.children, '6');
          final asset4 = getNodeById(asset3.children, '9');

          final orphanComponent = getNodeById(nodes, '15');

          // Asset 1 has 4 components
          expect(
            asset1,
            isA<AssetTreeNode>().having(
              (n) => n.locationId,
              'Asset 1 locationId',
              location1.id,
            ),
          );
          expect(
            asset1.children,
            isA<List<CompanyAssetTreeNode>>()
                .having((nodes) => nodes.length, 'Asset 1 children count', 4)
                .having(
                  (nodes) => nodes.every(
                    (n) =>
                        n is ComponentTreeNode &&
                        n.children.isEmpty &&
                        n.parentId == asset1.id,
                  ),
                  'Asset 1 children are all components',
                  true,
                )
                .having(
                  (nodes) => nodes.map((node) => node.id),
                  'Asset 1 children ids',
                  containsAll(['7', '8', '10', '11']),
                ),
          );

          // Asset 2 has no children
          expect(
            asset2,
            isA<AssetTreeNode>().having(
              (node) => node.locationId,
              'Asset 2 locationId',
              location2.id,
            ),
          );
          expect(asset2.children, isEmpty);

          // Asset 3 has Asset 4 as child
          expect(
            asset3,
            isA<AssetTreeNode>().having(
              (node) => node.locationId,
              'Asset 3 locationId',
              location3.id,
            ),
          );
          expect(
            asset3.children,
            isA<List<CompanyAssetTreeNode>>()
                .having((nodes) => nodes.length, 'Asset 3 children count', 1)
                .having(
                  (nodes) => nodes.first,
                  'Asset 3 child',
                  equals(asset4),
                ),
          );

          // Asset 4 has Asset 3 as parent
          expect(
            asset4,
            isA<AssetTreeNode>().having(
              (node) => node.parentId,
              'Asset 4 parentId',
              asset3.id,
            ),
          );
          expect(asset4.children, isEmpty);

          // Orphan component has no parent
          expect(
            orphanComponent,
            isA<ComponentTreeNode>()
                .having(
                  (node) => node.parentId,
                  'Orphan component parentId',
                  isNull,
                )
                .having(
                  (node) => node,
                  'Orphan component is in nodes',
                  nodes.contains,
                ),
          );

          return true;
        },
        'Asset tree structure is correct',
        true,
      ),
    ],
  );

  blocTest<CompanyAssetsBloc, CompanyAssetsState>(
    'Filters by name: returns only nodes matching the name',
    build: () => bloc,
    act: (bloc) async {
      bloc.add(GetCompanyAssetsEvent('1'));
      await Future.delayed(Duration(milliseconds: 500));
      bloc.add(
        FilterCompanyAssetsEvent(
          (filter) => filter.copyWith(byName: Nullable('Asset 1')),
        ),
      );
    },
    expect: () => [
      isA<CompanyAssetsLoadingState>(),
      isA<CompanyAssetsSuccessState>(),
      isA<CompanyAssetsSuccessState>().having(
        (state) {
          final location = getNodeById(state.nodes, '12');
          final asset = getNodeById(location.children, '4');

          return location.children.length == 1 &&
              asset.name.contains('Asset 1') &&
              asset.children.length == 4 &&
              asset.children.every((n) => n is ComponentTreeNode);
        },
        'Filtered nodes contain only Asset 1 and its components',
        true,
      ),
    ],
  );

  blocTest<CompanyAssetsBloc, CompanyAssetsState>(
    'Filters by sensor type: returns only components with matching sensor type',
    build: () => bloc,
    act: (bloc) async {
      bloc.add(GetCompanyAssetsEvent('1'));
      await Future.delayed(Duration(milliseconds: 500));
      bloc.add(
        FilterCompanyAssetsEvent(
          (filter) =>
              filter.copyWith(bySensorType: Nullable(SensorType.energy)),
        ),
      );
    },
    expect: () => [
      isA<CompanyAssetsLoadingState>(),
      isA<CompanyAssetsSuccessState>(),
      isA<CompanyAssetsSuccessState>().having(
        (state) {
          final location1 = getNodeById(state.nodes, '12');
          final asset1 = getNodeById(location1.children, '4');
          final component6 = getNodeById(state.nodes, '15');

          return state.nodes.length == 2 &&
              component6.children.isEmpty &&
              location1.children.length == 1 &&
              asset1.name.contains('Asset 1') &&
              asset1.children.length == 2 &&
              asset1.children.every(
                (node) =>
                    node is ComponentTreeNode &&
                    node.sensorType == SensorType.energy,
              );
        },
        'Filtered nodes contain only components with energy sensor type',
        true,
      ),
    ],
  );

  blocTest<CompanyAssetsBloc, CompanyAssetsState>(
    'Filters by sensor status: returns only components with matching sensor status',
    build: () => bloc,
    act: (bloc) async {
      bloc.add(GetCompanyAssetsEvent('1'));
      await Future.delayed(Duration(milliseconds: 500));
      bloc.add(
        FilterCompanyAssetsEvent(
          (filter) =>
              filter.copyWith(bySensorStatus: Nullable(SensorStatus.alert)),
        ),
      );
    },
    expect: () => [
      isA<CompanyAssetsLoadingState>(),
      isA<CompanyAssetsSuccessState>(),
      isA<CompanyAssetsSuccessState>().having(
        (state) {
          final location1 = getNodeById(state.nodes, '12');
          final asset1 = getNodeById(location1.children, '4');

          return state.nodes.length == 1 &&
              location1.children.length == 1 &&
              asset1.name.contains('Asset 1') &&
              asset1.children.length == 2 &&
              asset1.children.any(
                (node) =>
                    node is ComponentTreeNode &&
                    node.sensorStatus == SensorStatus.alert,
              );
        },
        'Filtered nodes contain only components with alert sensor status',
        true,
      ),
    ],
  );

  blocTest<CompanyAssetsBloc, CompanyAssetsState>(
    'Combined filter: name and sensor type',
    build: () => bloc,
    act: (bloc) async {
      bloc.add(GetCompanyAssetsEvent('1'));
      await Future.delayed(Duration(milliseconds: 500));
      bloc.add(
        FilterCompanyAssetsEvent(
          (filter) => filter.copyWith(
            byName: Nullable('Component'),
            bySensorType: Nullable(SensorType.energy),
          ),
        ),
      );
    },
    expect: () => [
      isA<CompanyAssetsLoadingState>(),
      isA<CompanyAssetsSuccessState>(),
      isA<CompanyAssetsSuccessState>().having(
        (state) {
          final location = getNodeById(state.nodes, '12');
          final asset = getNodeById(location.children, '4');
          final component6 = getNodeById(state.nodes, '15');

          return state.nodes.length == 2 &&
              component6.children.isEmpty &&
              component6.name.contains('Component') &&
              location.children.length == 1 &&
              asset.name.contains('Asset 1') &&
              asset.children.length == 2 &&
              asset.children.every(
                (node) =>
                    node is ComponentTreeNode &&
                    node.sensorType == SensorType.energy &&
                    node.name.contains('Component'),
              );
        },
        'Filtered nodes contain only components with energy sensor type and name containing "Component"',
        true,
      ),
    ],
  );

  blocTest<CompanyAssetsBloc, CompanyAssetsState>(
    'Empty results for non-matching filter',
    build: () => bloc,
    act: (bloc) async {
      bloc.add(GetCompanyAssetsEvent('1'));
      await Future.delayed(Duration(milliseconds: 500));
      bloc.add(
        FilterCompanyAssetsEvent(
          (filter) => filter.copyWith(byName: Nullable('NonExisting')),
        ),
      );
    },
    expect: () => [
      isA<CompanyAssetsLoadingState>(),
      isA<CompanyAssetsSuccessState>(),
      isA<CompanyAssetsSuccessState>().having(
        (state) => state.nodes,
        'Filtered nodes are empty',
        isEmpty,
      ),
    ],
  );
}
