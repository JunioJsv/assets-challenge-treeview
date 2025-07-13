import 'package:assets_challenge/data/models/companies_assets/asset.dart';
import 'package:assets_challenge/data/models/companies_assets/company.dart';
import 'package:assets_challenge/data/models/companies_assets/location.dart';
import 'package:assets_challenge/data/models/companies_assets/sensor_status.dart';
import 'package:assets_challenge/data/models/companies_assets/sensor_type.dart';
import 'package:assets_challenge/data/repositories/companies_assets/icompanies_assets_repository.dart';

// Hierarchical structure simulated by MockCompaniesAssetsRepository:
//
// ├─ Location 1 (id: `12`)
// │  └─ Asset 1 (id: `4`)
// │     ├─ Component 1 (id: `7`, sensorStatus: alert, sensorType: energy)
// │     ├─ Component 2 (id: `8`, sensorType: vibration)
// │     ├─ Component 4 (id: `10`, sensorStatus: operating, sensorType: energy)
// │     └─ Component 5 (id: `11`, sensorType: vibration, sensorStatus: alert)
// ├─ Location 2 (id: `13`)
// │  └─ Asset 2 (id: `5`)
// │  └─ Location 3 (id: `14`, parentId: `13`)
// │     └─ Asset 3 (id: `6`)
// │        └─ Asset 4 (id: `9`)
// │─ Component 6 (id: `15`, sensorType: energy)
// This structure is used to simulate query operations in CompaniesBloc.
class MockCompaniesAssetsRepository implements ICompaniesAssetsRepository {
  @override
  Future<List<Company>> getCompanies() {
    return Future.value([
      Company(id: '1', name: 'Company A'),
      Company(id: '2', name: 'Company B'),
      Company(id: '3', name: 'Company C'),
    ]);
  }

  @override
  Future<List<Asset>> getCompanyAssets(String companyId) {
    return Future.value([
      Asset(id: '4', name: 'Asset 1', locationId: '12'),
      Asset(id: '5', name: 'Asset 2', locationId: '13'),
      Asset(id: '6', name: 'Asset 3', locationId: '14'),
      Asset(id: '9', name: 'Asset 4', parentId: '6'),

      Asset(
        id: '7',
        name: 'Component 1',
        parentId: '4',
        sensorStatus: SensorStatus.alert,
        sensorType: SensorType.energy,
      ),
      Asset(
        id: '8',
        name: 'Component 2',
        parentId: '4',
        sensorType: SensorType.vibration,
      ),
      Asset(
        id: '10',
        name: 'Component 4',
        parentId: '4',
        sensorStatus: SensorStatus.operating,
        sensorType: SensorType.energy,
      ),
      Asset(
        id: '11',
        name: 'Component 5',
        parentId: '4',
        sensorType: SensorType.vibration,
        sensorStatus: SensorStatus.alert,
      ),

      Asset(id: '15', name: 'Component 6', sensorType: SensorType.energy),
    ]);
  }

  @override
  Future<List<Location>> getCompanyLocations(String companyId) {
    return Future.value([
      Location(id: '12', name: 'Location 1'),
      Location(id: '13', name: 'Location 2'),
      Location(id: '14', name: 'Location 3', parentId: '13'),
    ]);
  }
}
