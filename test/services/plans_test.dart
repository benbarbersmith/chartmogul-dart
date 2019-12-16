import 'package:chartmogul/chartmogul.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

const String uuid = 'pl_eed05d54-75b4-431b-adb2-eb6b9e543206';
const String plansEndpoint = 'https://api.chartmogul.com/v1/plans';
const String dataSourceUuid = 'ds_fef05d54-47b4-431b-aed2-eb6b9e545430';
const int intervalCount = 1;
const String intervalUnit = 'month';
const String externalId = 'plan_0001';
const String name = 'Bronze Plan';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  final MockHttpClient mockClient = MockHttpClient();
  final ChartMogul chartMogul = ChartMogul(
    accountToken: '',
    secretKey: '',
    client: mockClient,
  );

  test('get method sends a get request to $plansEndpoint/\$uuid', () async {
    when(mockClient.get(
      '$plansEndpoint/$uuid',
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('''{
   "uuid": "pl_eed05d54-75b4-431b-adb2-eb6b9e543206",
   "data_source_uuid": "ds_fef05d54-47b4-431b-aed2-eb6b9e545430",
   "name": "Bronze Plan",
   "interval_count": 1,
   "interval_unit": "month",
   "external_id": "plan_0001"
}''', 200)));

    final Plan plan = await chartMogul.plans.get(uuid);

    verify(
        mockClient.get('$plansEndpoint/$uuid', headers: anyNamed('headers')));
    expect(plan.uuid, equals(uuid));
    expect(plan.externalId, equals(externalId));
    expect(plan.name, equals(name));
    expect(plan.dataSourceUuid, equals(dataSourceUuid));
    expect(plan.intervalUnit, equals(intervalUnit));
    expect(plan.intervalCount, equals(intervalCount));
  });

  test('delete method sends a delete request to $plansEndpoint/\$uuid',
      () async {
    final http.Response emptyResponse = http.Response('{}', 200);
    when(mockClient.delete(
      '$plansEndpoint/$uuid',
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(emptyResponse));

    await chartMogul.plans.delete(uuid);
    verify(mockClient.delete('$plansEndpoint/$uuid',
        headers: anyNamed('headers')));
  });

  test('create method sends a post request to $plansEndpoint', () async {
    when(mockClient.post(
      plansEndpoint,
      body: anyNamed('body'),
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('''{
   "uuid": "pl_eed05d54-75b4-431b-adb2-eb6b9e543206",
   "data_source_uuid": "ds_fef05d54-47b4-431b-aed2-eb6b9e545430",
   "name": "Bronze Plan",
   "interval_count": 1,
   "interval_unit": "month",
   "external_id": "plan_0001"
}''', 200)));

    final Plan plan = await chartMogul.plans.create(
      externalId: externalId,
      name: name,
      dataSourceUuid: dataSourceUuid,
      intervalCount: intervalCount,
      intervalUnit: intervalUnit,
    );

    final Map<String, dynamic> body = verify(mockClient.post(
      plansEndpoint,
      body: captureAnyNamed('body'),
      headers: anyNamed('headers'),
    )).captured.single;

    expect(
      body,
      equals(<String, dynamic>{
        'data_source_uuid': dataSourceUuid,
        'external_id': externalId,
        'name': name,
        'interval_unit': intervalUnit,
        'interval_count': intervalCount,
      }),
    );

    expect(plan.uuid, equals(uuid));
    expect(plan.externalId, equals(externalId));
    expect(plan.name, equals(name));
    expect(plan.dataSourceUuid, equals(dataSourceUuid));
    expect(plan.intervalCount, equals(intervalCount));
    expect(plan.intervalUnit, equals(intervalUnit));
  });

  test('list method sends a get request to $plansEndpoint', () async {
    when(mockClient.get(
      plansEndpoint,
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('''{
  "plans":[
    {
      "uuid": "pl_eed05d54-75b4-431b-adb2-eb6b9e543206",
      "data_source_uuid": "ds_fef05d54-47b4-431b-aed2-eb6b9e545430",
      "name": "Bronze Plan",
      "interval_count": 1,
      "interval_unit": "month",
      "external_id": "plan_0001"
    },
    {
      "uuid": "pl_cdb35d54-75b4-431b-adb2-eb6b9e873425",
      "data_source_uuid": "ds_fef05d54-47b4-431b-aed2-eb6b9e545430",
      "name": "Silver Plan",
      "interval_count": 6,
      "interval_unit": "month",
      "external_id": "plan_0002"
    },
    {
      "uuid": "pl_ab225d54-7ab4-421b-cdb2-eb6b9e553462",
      "data_source_uuid": "ds_fef05d54-47b4-431b-aed2-eb6b9e545430",
      "name": "Gold Plan",
      "interval_count": 1,
      "interval_unit": "year",
      "external_id": "plan_0003"
    }
  ],
  "current_page": 1,
  "total_pages": 2
}''', 200)));

    final PlanResults results = await chartMogul.plans.list();

    verify(mockClient.get(plansEndpoint, headers: anyNamed('headers')));

    expect(results.entries.length, equals(3));
    expect(results.currentPage, equals(1));
    expect(results.totalPages, equals(2));
  });

  test(
      'list method sends a get request with correct parameters to $plansEndpoint',
      () async {
    when(mockClient.get(
      any,
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('{}', 200)));

    await chartMogul.plans.list(page: 1);
    verify(
        mockClient.get('$plansEndpoint?page=1', headers: anyNamed('headers')));

    await chartMogul.plans.list(externalId: '1a');
    verify(mockClient.get('$plansEndpoint?external_id=1a',
        headers: anyNamed('headers')));

    await chartMogul.plans.list(perPage: 3);
    verify(mockClient.get('$plansEndpoint?per_page=3',
        headers: anyNamed('headers')));

    await chartMogul.plans.list(system: 'Stripe');
    verify(mockClient.get('$plansEndpoint?system=Stripe',
        headers: anyNamed('headers')));

    await chartMogul.plans
        .list(dataSourceUuid: 'ds_ab223d54-75b4-431b-adb2-eb6b9e234571');
    verify(mockClient.get(
        '$plansEndpoint?data_source_uuid=ds_ab223d54-75b4-431b-adb2-eb6b9e234571',
        headers: anyNamed('headers')));

    await chartMogul.plans.list(
        page: 1,
        perPage: 2,
        externalId: '1a',
        dataSourceUuid: 'ds_ab223d54-75b4-431b-adb2-eb6b9e234571');
    final String url =
        verify(mockClient.get(captureAny, headers: anyNamed('headers')))
            .captured
            .single;

    expect(url, startsWith('$plansEndpoint?'));
    expect(url, contains('page=1'));
    expect(url, contains('per_page=2'));
    expect(url, contains('external_id=1a'));
    expect(url,
        contains('data_source_uuid=ds_ab223d54-75b4-431b-adb2-eb6b9e234571'));
  });

  test('update method sends a patch request to $plansEndpoint/\$uuid',
      () async {
    when(mockClient.patch(
      '$plansEndpoint/$uuid',
      body: anyNamed('body'),
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('''{
   "uuid": "pl_eed05d54-75b4-431b-adb2-eb6b9e543206",
   "data_source_uuid": "ds_fef05d54-47b4-431b-aed2-eb6b9e545430",
   "name": "Bronze Monthly Plan",
   "interval_count": 1,
   "interval_unit": "month",
   "external_id": "plan_0001"
}''', 200)));

    final Plan plan = await chartMogul.plans.update(
      uuid: uuid,
      name: 'Bronze Monthly Plan',
    );

    verify(mockClient.patch(
      '$plansEndpoint/$uuid',
      body: argThat(
          equals(<String, dynamic>{
            'name': 'Bronze Monthly Plan',
          }),
          named: 'body'),
      headers: anyNamed('headers'),
    ));

    expect(plan.uuid, equals(uuid));
    expect(plan.externalId, equals(externalId));
    expect(plan.dataSourceUuid, equals(dataSourceUuid));
    expect(plan.intervalUnit, equals(intervalUnit));
    expect(plan.intervalCount, equals(intervalCount));
    expect(plan.name, equals('Bronze Monthly Plan'));
  });
}
