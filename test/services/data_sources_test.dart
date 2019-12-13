import 'package:chartmogul/chartmogul.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

const String dataSourcesEndpoint = 'https://api.chartmogul.com/v1/data_sources';
const String uuid = 'ds_fef05d54-47b4-431b-aed2-eb6b9e545430';
const String name = 'In-house billing';
const String system = 'Import API';
const String statusString = 'idle';
const DataSourceStatus status = DataSourceStatus.idle;
const String createdAtString = '2016-01-10T15:34:05Z';

final DateTime createdAt = DateTime.parse('$createdAtString');

class MockHttpClient extends Mock implements http.Client {}

void main() {
  final MockHttpClient mockClient = MockHttpClient();
  final ChartMogul chartMogul = ChartMogul(
    accountToken: '',
    secretKey: '',
    client: mockClient,
  );

  test('get method sends a get request to $dataSourcesEndpoint/\$uuid',
      () async {
    when(mockClient.get(
      '$dataSourcesEndpoint/$uuid',
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('''{
    "uuid": "$uuid",
    "name": "$name",
    "system": "$system",
    "created_at": "$createdAtString",
    "status": "$statusString"
}''', 200)));

    final DataSource dataSource = await chartMogul.dataSources.get(uuid);

    verify(mockClient.get('$dataSourcesEndpoint/$uuid',
        headers: anyNamed('headers')));
    expect(dataSource.name, equals(name));
    expect(dataSource.uuid, equals(uuid));
    expect(dataSource.createdAt, equals(createdAt));
    expect(dataSource.system, equals(system));
    expect(dataSource.status, equals(status));
  });

  test('delete method sends a delete request to $dataSourcesEndpoint/\$uuid',
      () async {
    final http.Response emptyResponse = http.Response('{}', 200);
    when(mockClient.delete(
      '$dataSourcesEndpoint/$uuid',
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(emptyResponse));

    await chartMogul.dataSources.delete(uuid);
    verify(mockClient.delete('$dataSourcesEndpoint/$uuid',
        headers: anyNamed('headers')));
  });

  test('create method sends a post request to $dataSourcesEndpoint', () async {
    when(mockClient.post(
      dataSourcesEndpoint,
      body: anyNamed('body'),
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('''{
    "uuid": "$uuid",
    "name": "$name",
    "system": "$system",
    "created_at": "$createdAtString",
    "status": "$statusString"
}''', 200)));

    final DataSource dataSource = await chartMogul.dataSources.create(name);

    verify(mockClient.post(
      dataSourcesEndpoint,
      body: argThat(equals(<String, String>{'name': name}), named: 'body'),
      headers: anyNamed('headers'),
    ));
    expect(dataSource.name, equals(name));
    expect(dataSource.uuid, equals(uuid));
    expect(dataSource.createdAt, equals(createdAt));
    expect(dataSource.system, equals(system));
    expect(dataSource.status, equals(status));
  });

  test('list method sends a get request to $dataSourcesEndpoint', () async {
    const String secondName = 'Enterprise billing connection';
    const String secondUuid = 'ds_ade45e52-47a4-231a-1ed2-eb6b9e541213';
    const String firstCreatedAtString = '2016-01-10 15:34:05';
    const String secondCreatedAtString = '2016-01-09 10:14:15';

    when(mockClient.get(
      dataSourcesEndpoint,
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('''{
  "data_sources": [
    {
      "uuid": "$uuid",
      "name": "$name",
      "system": "$system",
      "created_at": "$firstCreatedAtString",
      "status": "$statusString"
    },
    {
      "uuid": "$secondUuid",
      "name": "$secondName",
      "system": "$system",
      "created_at": "$secondCreatedAtString",
      "status": "$statusString"
    }
  ]
}''', 200)));

    final List<DataSource> dataSources = await chartMogul.dataSources.list();

    verify(mockClient.get(dataSourcesEndpoint, headers: anyNamed('headers')));

    expect(dataSources.length, equals(2));

    final DataSource firstDataSource = dataSources
        .firstWhere((DataSource d) => d.uuid == uuid, orElse: () => null);
    expect(firstDataSource, isNotNull);

    expect(firstDataSource.name, equals(name));
    expect(firstDataSource.uuid, equals(uuid));
    expect(firstDataSource.createdAt.millisecondsSinceEpoch,
        equals(createdAt.millisecondsSinceEpoch));
    expect(firstDataSource.system, equals(system));
    expect(firstDataSource.status, equals(status));

    final DataSource secondDataSource = dataSources
        .firstWhere((DataSource d) => d.uuid == secondUuid, orElse: () => null);
    expect(secondDataSource, isNotNull);

    expect(secondDataSource.name, equals(secondName));
    expect(secondDataSource.uuid, equals(secondUuid));
    expect(secondDataSource.createdAt.millisecondsSinceEpoch,
        equals(DateTime.parse(secondCreatedAtString).millisecondsSinceEpoch));
    expect(secondDataSource.system, equals(system));
    expect(secondDataSource.status, equals(status));
  });
}
