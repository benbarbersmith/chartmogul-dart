import 'package:chartmogul/chartmogul.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

const String customerUuid = 'cus_f466e33d-ff2b-4a11-8f85-417eb02157a7';
const String listSubscriptionsEndpoint =
    'https://api.chartmogul.com/v1/import/customers/$customerUuid/subscriptions';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  final MockHttpClient mockClient = MockHttpClient();
  final ChartMogul chartMogul = ChartMogul(
    accountToken: '',
    secretKey: '',
    client: mockClient,
  );

  test('list method sends a get request to $listSubscriptionsEndpoint',
      () async {
    when(mockClient.get(
      listSubscriptionsEndpoint,
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('''{
  "customer_uuid": "cus_f466e33d-ff2b-4a11-8f85-417eb02157a7",
  "subscriptions":[
    {
      "uuid": "sub_e6bc5407-e258-4de0-bb43-61faaf062035",
      "external_id": "sub_0001",
      "subscription_set_external_id": "set_0001",
      "plan_uuid": "pl_eed05d54-75b4-431b-adb2-eb6b9e543206",
      "data_source_uuid": "ds_fef05d54-47b4-431b-aed2-eb6b9e545430",
      "cancellation_dates":[]
    }
  ],
  "current_page": 1,
  "total_pages": 1
}''', 200)));

    final SubscriptionResults results =
        await chartMogul.subscriptions.list(customerUuid: customerUuid);

    verify(mockClient.get(listSubscriptionsEndpoint,
        headers: anyNamed('headers')));

    expect(results.entries.length, equals(1));
    expect(results.currentPage, equals(1));
    expect(results.totalPages, equals(1));

    final Subscription subscription = results.entries.first;
    expect(
        subscription.uuid, equals('sub_e6bc5407-e258-4de0-bb43-61faaf062035'));
    expect(subscription.externalId, equals('sub_0001'));
    expect(subscription.dataSourceUuid,
        equals('ds_fef05d54-47b4-431b-aed2-eb6b9e545430'));
    expect(subscription.planUuid,
        equals('pl_eed05d54-75b4-431b-adb2-eb6b9e543206'));
    expect(subscription.subscriptionSetExternalId, equals('set_0001'));
    expect(subscription.cancellationDates, isEmpty);
  });

  test(
      'list method sends a get request with correct parameters to $listSubscriptionsEndpoint',
      () async {
    when(mockClient.get(
      any,
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('{}', 200)));

    await chartMogul.subscriptions.list(customerUuid: customerUuid, page: 1);
    verify(mockClient.get('$listSubscriptionsEndpoint?page=1',
        headers: anyNamed('headers')));

    await chartMogul.subscriptions.list(customerUuid: customerUuid, perPage: 3);
    verify(mockClient.get('$listSubscriptionsEndpoint?per_page=3',
        headers: anyNamed('headers')));

    await chartMogul.subscriptions
        .list(customerUuid: customerUuid, page: 1, perPage: 2);
    final String url =
        verify(mockClient.get(captureAny, headers: anyNamed('headers')))
            .captured
            .single;

    expect(url, startsWith('$listSubscriptionsEndpoint?'));
    expect(url, contains('page=1'));
    expect(url, contains('per_page=2'));
  });

  test(
      'cancel method sends a patch request to https://api.chartmogul.com/v1/import/subscriptions/\$uuid',
      () async {
    const String subscriptionUuid = 'sub_e6bc5407-e258-4de0-bb43-61faaf062035';

    when(mockClient.patch(
      'https://api.chartmogul.com/v1/import/subscriptions/sub_e6bc5407-e258-4de0-bb43-61faaf062035',
      body: anyNamed('body'),
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('''{
  "uuid": "sub_e6bc5407-e258-4de0-bb43-61faaf062035",
  "external_id": "sub_0001",
  "customer_uuid": "cus_f466e33d-ff2b-4a11-8f85-417eb02157a7",
  "plan_uuid": "pl_eed05d54-75b4-431b-adb2-eb6b9e543206",
  "cancellation_dates": ["2016-01-15T00:00:00.000Z"],
  "data_source_uuid": "ds_fef05d54-47b4-431b-aed2-eb6b9e545430"
}''', 200)));

    final Subscription subscription1 = await chartMogul.subscriptions.cancel(
      uuid: subscriptionUuid,
      cancelledAt: DateTime.parse('2016-01-15 00:00:00'),
    );

    verify(mockClient.patch(
      'https://api.chartmogul.com/v1/import/subscriptions/$subscriptionUuid',
      body: argThat(
          equals(<String, dynamic>{
            'cancelled_at':
                DateTime.parse('2016-01-15 00:00:00').toIso8601String(),
          }),
          named: 'body'),
      headers: anyNamed('headers'),
    ));

    expect(subscription1.uuid, equals(subscriptionUuid));
    expect(subscription1.cancellationDates,
        equals(<DateTime>[DateTime.parse('2016-01-15T00:00:00.000Z')]));
    when(mockClient.patch(
      'https://api.chartmogul.com/v1/import/subscriptions/sub_e6bc5407-e258-4de0-bb43-61faaf062035',
      body: anyNamed('body'),
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('''{
  "uuid": "sub_e6bc5407-e258-4de0-bb43-61faaf062035",
  "external_id": "sub_0001",
  "customer_uuid": "cus_f466e33d-ff2b-4a11-8f85-417eb02157a7",
  "plan_uuid": "pl_eed05d54-75b4-431b-adb2-eb6b9e543206",
  "cancellation_dates": ["2016-01-01T10:00:00.000Z", "2017-01-01T10:00:00.000Z"],
  "data_source_uuid": "ds_fef05d54-47b4-431b-aed2-eb6b9e545430"
}''', 200)));

    final List<DateTime> cancellationDates = <String>[
      '2016-01-01T10:00:00.000Z',
      '2017-01-01T10:00:00.000Z',
    ].map((String s) => DateTime.parse(s)).toList();

    final Subscription subscription2 = await chartMogul.subscriptions.cancel(
      uuid: subscriptionUuid,
      cancellationDates: cancellationDates,
    );

    verify(mockClient.patch(
      'https://api.chartmogul.com/v1/import/subscriptions/$subscriptionUuid',
      body: argThat(
          equals(<String, dynamic>{
            'cancellation_dates': cancellationDates
                .map((DateTime d) => d.toIso8601String())
                .toList(),
          }),
          named: 'body'),
      headers: anyNamed('headers'),
    ));

    expect(subscription2.uuid, equals(subscriptionUuid));
    expect(subscription2.cancellationDates, equals(cancellationDates));
  });
}
