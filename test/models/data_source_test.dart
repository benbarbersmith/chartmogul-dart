import 'package:chartmogul/src/models/data_source.dart';
import 'package:test/test.dart';

const Map<String, dynamic> map = <String, dynamic>{
  'uuid': 'ds_fef05d54-47b4-431b-aed2-eb6b9e545430',
  'name': 'In-house billing',
  'system': 'Import API',
  'status': 'idle',
  'created_at': '2016-01-10T15:34:05Z',
};

void main() {
  test('DataSource can be created from expected JSON', () {
    final DataSource dataSource = DataSource.fromJson(map);

    expect(dataSource.name, equals(map['name']));
    expect(dataSource.uuid, equals(map['uuid']));
    expect(dataSource.createdAt, equals(DateTime.parse(map['created_at'])));
    expect(dataSource.system, equals(map['system']));
    expect(dataSource.status, equals(DataSourceStatus.idle));
  });

  test('DataSourceStatus is mapped correctly from strings', () {
    const Map<String, DataSourceStatus> statusStringMapping =
        <String, DataSourceStatus>{
      'never_imported': DataSourceStatus.never_imported,
      'importing': DataSourceStatus.importing,
      'import_complete': DataSourceStatus.import_complete,
      'working': DataSourceStatus.working,
      'idle': DataSourceStatus.idle,
    };

    for (final String statusString in statusStringMapping.keys) {
      final Map<String, dynamic> testMap = Map<String, dynamic>.from(map);
      testMap['status'] = statusString;

      final DataSource dataSource = DataSource.fromJson(testMap);
      expect(dataSource.status, equals(statusStringMapping[statusString]));
    }
  });
}
