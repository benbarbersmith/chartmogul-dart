import 'package:chartmogul/chartmogul.dart';
import 'package:chartmogul/src/models/customer_attributes.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

const String customersEndpoint = 'https://api.chartmogul.com/v1/customers';
const String dataSourceUuid = 'ds_fef05d54-47b4-431b-aed2-eb6b9e545430';
const List<String> dataSourceUuids = <String>[
  'ds_fef05d54-47b4-431b-aed2-eb6b9e545430',
];
const String currency = 'USD';
const String currencySign = '\$';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  final MockHttpClient mockClient = MockHttpClient();
  final ChartMogul chartMogul = ChartMogul(
    accountToken: '',
    secretKey: '',
    client: mockClient,
  );

  test('get method sends a get request to $customersEndpoint/\$uuid', () async {
    const int id = 25647;
    const String uuid = 'cus_de305d54-75b4-431b-adb2-eb6b9e546012';
    const String name = 'Example Company';
    const String email = 'bob@examplecompany.com';
    const String externalId = '34916129';
    const String status = 'Active';
    const String customerSinceString = '2015-06-09T13:16:00-04:00';
    const Address address = Address(
      city: 'Nowhereville',
      state: 'Alaska',
      country: 'US',
      zip: '0185128',
    );
    const List<String> externalIds = <String>['34916129'];
    const String company = '';
    const int mrr = 3000;
    const int arr = 36000;
    const String billingSystemUrl =
        'https:\/\/dashboard.stripe.com\/customers\/cus_4Z2ZpyJFuQ0XMb';
    const String chartmogulUrl =
        'https:\/\/app.chartmogul.com\/#customers\/25647-Example_Company';
    const String billingSystemType = 'Stripe';
    const List<String> tags = <String>['engage', 'unit loss', 'discountable'];
    const Map<String, dynamic> custom = <String, dynamic>{
      'CAC': 213,
      'utmCampaign': 'social media 1',
      'convertedAt': '2015-09-08 00:00:00',
      'pro': false,
      'salesRep': 'Gabi'
    };
    final DateTime customerSince = DateTime.parse('$customerSinceString');

    when(mockClient.get(
      '$customersEndpoint/$uuid',
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('''{
  "id": 25647,
  "uuid": "cus_de305d54-75b4-431b-adb2-eb6b9e546012",
  "external_id": "34916129",
  "name": "Example Company",
  "email": "bob@examplecompany.com",
  "status": "Active",
  "customer-since": "2015-06-09T13:16:00-04:00",
  "attributes": {
    "tags": ["engage", "unit loss", "discountable"],
    "stripe": {
      "uid": 7,
      "coupon": true
    }, 
    "clearbit": {
      "id": "027b0d40-016c-40ea-8925-a076fa640992",
      "name": "Acme",
      "legalName": "Acme Inc.",
      "domain": "acme.com",
      "url": "http://acme.com",
      "metrics": {
        "raised": 1502450000,
        "employees": 1000,
        "googleRank": 7,
        "alexaGlobalRank": 2319,
        "marketCap": null
      },
      "category": {
        "sector": "Information Technology",
        "industryGroup": "Software and Services",
        "industry": "Software",
        "subIndustry": "Application Software"
      }
    },
    "custom": {
      "CAC": 213,
      "utmCampaign": "social media 1",
      "convertedAt": "2015-09-08 00:00:00",
      "pro": false,
      "salesRep": "Gabi"
    }
  },
  "address": {
    "address_zip": "0185128",
    "city": "Nowhereville",
    "state": "Alaska",
    "country": "US"
  },
  "data_source_uuid": "ds_fef05d54-47b4-431b-aed2-eb6b9e545430",
  "data_source_uuids": ["ds_fef05d54-47b4-431b-aed2-eb6b9e545430"],
  "external_ids": ["34916129"],
  "company": "",
  "country": "US",
  "state": "Alaska",
  "city": "Nowhereville",
  "zip": "0185128",
  "lead_created_at": null,
  "free_trial_started_at": null,
  "mrr": 3000,
  "arr": 36000,
  "billing-system-url": "https:\/\/dashboard.stripe.com\/customers\/cus_4Z2ZpyJFuQ0XMb",
  "chartmogul-url": "https:\/\/app.chartmogul.com\/#customers\/25647-Example_Company",
  "billing-system-type": "Stripe",
  "currency": "USD",
  "currency-sign": "\$"
}''', 200)));

    final Customer customer = await chartMogul.customers.get(uuid);

    verify(mockClient.get('$customersEndpoint/$uuid',
        headers: anyNamed('headers')));
    expect(customer.id, equals(id));
    expect(customer.uuid, equals(uuid));
    expect(customer.externalId, equals(externalId));
    expect(customer.name, equals(name));
    expect(customer.email, equals(email));
    expect(customer.status, equals(status));
    expect(customer.customerSince, equals(customerSince));
    expect(customer.address.zip, equals(address.zip));
    expect(customer.address.city, equals(address.city));
    expect(customer.address.state, equals(address.state));
    expect(customer.address.country, equals(address.country));
    expect(customer.dataSourceUuid, equals(dataSourceUuid));
    expect(customer.dataSourceUuids, equals(dataSourceUuids));
    expect(customer.externalIds, equals(externalIds));
    expect(customer.company, equals(company));
    expect(customer.leadCreatedAt, isNull);
    expect(customer.freeTrialStartedAt, isNull);
    expect(customer.mrr, equals(mrr));
    expect(customer.arr, equals(arr));
    expect(customer.billingSystemUrl, equals(billingSystemUrl));
    expect(customer.chartmogulUrl, equals(chartmogulUrl));
    expect(customer.billingSystemType, equals(billingSystemType));
    expect(customer.currency, equals(currency));
    expect(customer.currencySign, equals(currencySign));
    expect(customer.attributes, isNotNull);
    expect(customer.attributes.tags, equals(tags));
    expect(customer.attributes.custom, equals(custom));
    expect(customer.attributes.stripe,
        equals(<String, dynamic>{'uid': 7, 'coupon': true}));
    expect(
        customer.attributes.clearbit,
        equals(<String, dynamic>{
          'id': '027b0d40-016c-40ea-8925-a076fa640992',
          'name': 'Acme',
          'legalName': 'Acme Inc.',
          'domain': 'acme.com',
          'url': 'http://acme.com',
          'metrics': <String, dynamic>{
            'raised': 1502450000,
            'employees': 1000,
            'googleRank': 7,
            'alexaGlobalRank': 2319,
            'marketCap': null
          },
          'category': <String, dynamic>{
            'sector': 'Information Technology',
            'industryGroup': 'Software and Services',
            'industry': 'Software',
            'subIndustry': 'Application Software'
          }
        }));
  });

  test('delete method sends a delete request to $customersEndpoint/\$uuid',
      () async {
    const String uuid = 'cus_de305d54-75b4-431b-adb2-eb6b9e546012';
    final http.Response emptyResponse = http.Response('{}', 200);
    when(mockClient.delete(
      '$customersEndpoint/$uuid',
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(emptyResponse));

    await chartMogul.customers.delete(uuid);
    verify(mockClient.delete('$customersEndpoint/$uuid',
        headers: anyNamed('headers')));
  });

  test('create method sends a post request to $customersEndpoint', () async {
    const int id = 74596;
    const String uuid = 'cus_f466e33d-ff2b-4a11-8f85-417eb02157a7';
    const String name = 'Adam Smith';
    const String email = 'adam@smith.com';
    const String externalId = 'cus_0001';
    const String status = 'Lead';
    const Address address = Address(city: 'New York', country: 'US');
    const List<String> externalIds = <String>['cus_0001'];
    const String company = '';
    const int mrr = 0;
    const int arr = 0;
    const String chartmogulUrl =
        'https://app.chartmogul.com/#customers/74596-Adam_Smith';
    const String billingSystemType = 'Import API';
    final DateTime leadCreatedAt = DateTime.parse('2015-10-14T00:00:00Z');
    final DateTime freeTrialStartedAt = DateTime.parse('2015-11-01T00:00:00Z');
    const List<String> tags = <String>['important', 'Prio1'];
    final List<CustomAttribute> custom = <CustomAttribute>[
      CustomAttribute(key: 'channel', value: 'Facebook', source: 'Integration'),
      CustomAttribute(key: 'age', value: 18),
    ];

    when(mockClient.post(
      customersEndpoint,
      body: anyNamed('body'),
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('''{
  "id": 74596,
  "uuid": "cus_f466e33d-ff2b-4a11-8f85-417eb02157a7",
  "external_id": "cus_0001",
  "name": "Adam Smith",
  "email": "adam@smith.com",
  "status": "Lead",
  "customer-since": null,
  "attributes": {
    "custom": {
      "channel": "Facebook",
      "age": 18
    },
    "clearbit": {},
    "stripe": {},
    "tags": [
      "important",
      "Prio1"
    ]
  },
  "data_source_uuid": "ds_fef05d54-47b4-431b-aed2-eb6b9e545430",
  "data_source_uuids": [
    "ds_fef05d54-47b4-431b-aed2-eb6b9e545430"
  ],
  "external_ids": [
    "cus_0001"
  ],
  "company": "",
  "country": "US",
  "state": null,
  "city": "New York",
  "zip": null,
  "lead_created_at": "2015-10-14T00:00:00Z",
  "free_trial_started_at": "2015-11-01T00:00:00Z",
  "address": {
    "country": "US",
    "state": null,
    "city": "New York",
    "address_zip": null
  },
  "mrr": 0,
  "arr": 0,
  "billing-system-url": null,
  "chartmogul-url": "https://app.chartmogul.com/#customers/74596-Adam_Smith",
  "billing-system-type": "Import API",
  "currency": "USD",
  "currency-sign": "\$"
}''', 200)));

    final Customer customer = await chartMogul.customers.create(
      externalId: externalId,
      name: name,
      dataSourceUuid: dataSourceUuid,
      email: email,
      address: address,
      leadCreatedAt: leadCreatedAt,
      freeTrialStartedAt: freeTrialStartedAt,
      customAttributes: custom,
      tags: tags,
    );

    final Map<String, dynamic> body = verify(mockClient.post(
      customersEndpoint,
      body: captureAnyNamed('body'),
      headers: anyNamed('headers'),
    )).captured.single;

    expect(
      body,
      equals(<String, dynamic>{
        'data_source_uuid': dataSourceUuid,
        'external_id': externalId,
        'name': name,
        'email': email,
        'country': address.country,
        'city': address.city,
        'lead_created_at': '2015-10-14T00:00:00.000Z',
        'free_trial_started_at': '2015-11-01T00:00:00.000Z',
        'attributes': <String, dynamic>{
          'tags': tags,
          'custom': <Map<String, dynamic>>[
            <String, dynamic>{
              'type': 'String',
              'key': 'channel',
              'value': 'Facebook',
              'source': 'Integration',
            },
            <String, dynamic>{
              'type': 'Integer',
              'key': 'age',
              'value': 18,
            }
          ],
        }
      }),
    );

    expect(customer.id, equals(id));
    expect(customer.uuid, equals(uuid));
    expect(customer.externalId, equals(externalId));
    expect(customer.name, equals(name));
    expect(customer.email, equals(email));
    expect(customer.status, equals(status));
    expect(customer.customerSince, isNull);
    expect(customer.address.zip, equals(address.zip));
    expect(customer.address.city, equals(address.city));
    expect(customer.address.state, equals(address.state));
    expect(customer.address.country, equals(address.country));
    expect(customer.dataSourceUuid, equals(dataSourceUuid));
    expect(customer.dataSourceUuids, equals(dataSourceUuids));
    expect(customer.externalIds, equals(externalIds));
    expect(customer.company, equals(company));
    expect(customer.leadCreatedAt, leadCreatedAt);
    expect(customer.freeTrialStartedAt, freeTrialStartedAt);
    expect(customer.mrr, equals(mrr));
    expect(customer.arr, equals(arr));
    expect(customer.billingSystemUrl, isNull);
    expect(customer.chartmogulUrl, equals(chartmogulUrl));
    expect(customer.billingSystemType, equals(billingSystemType));
    expect(customer.currency, equals(currency));
    expect(customer.currencySign, equals(currencySign));
    expect(customer.attributes, isNotNull);
    expect(customer.attributes.tags, equals(tags));
    expect(customer.attributes.custom,
        equals(<String, dynamic>{'channel': 'Facebook', 'age': 18}));
    expect(customer.attributes.stripe, isEmpty);
    expect(customer.attributes.clearbit, isEmpty);
  });

  test('list method sends a get request to $customersEndpoint', () async {
    when(mockClient.get(
      customersEndpoint,
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('''{
  "entries":[
    {
      "id": 25647,
      "uuid": "cus_de305d54-75b4-431b-adb2-eb6b9e546012",
      "external_id": "34916129",
      "external_ids": ["34916129"],
      "data_source_uuid": "ds_610b7a84-c50f-11e6-8aab-97d6db98913a",
      "data_source_uuids": ["ds_610b7a84-c50f-11e6-8aab-97d6db98913a"],
      "name": "Example Company",
      "company": "",
      "email": "bob@examplecompany.com",
      "status": "Active",
      "lead_created_at": "2015-01-01T10:00:00-04:00",
      "free_trial_started_at": "2015-01-09T10:00:00-04:00",
      "customer-since": "2015-06-09T13:16:00-04:00",
      "city": "Nowhereville",
      "state": "Alaska",
      "country": "US",
      "zip": "0185128",
      "attributes":{
        "tags": ["engage", "unit loss", "discountable"],
        "stripe":{
          "uid": 7,
          "coupon": true
        },
        "clearbit":{
          "company":{
            "name": "Example Company",
            "legalName": "Example Company Inc.",
            "domain": "examplecompany.com",
            "url": "http://examplecompany.com",
            "category":{
              "sector": "Information Technology",
              "industryGroup": "Software and Services",
              "industry": "Software",
              "subIndustry": "Application Software"
            },
            "metrics":{
              "raised": 1502450000,
              "employees": 1000,
              "googleRank": 7,
              "alexaGlobalRank": 2319,
              "marketCap": null
            }
          },
          "person":{
            "name":{
              "fullName": "Bob Kramer"
            },
            "employment":{
              "name": "Example Company"
            }
          }
        },
        "custom":{
          "CAC": 213,
          "utmCampaign": "social media 1",
          "convertedAt": "2015-09-08 00:00:00",
          "pro": false,
          "salesRep": "Gabi"
        }
      },
      "address":{
        "address_zip": "0185128",
        "city": "Nowhereville",
        "country": "US",
        "state": "Alaska"
      },
      "mrr": 3000,
      "arr": 36000,
      "billing-system-url": "https:\/\/dashboard.stripe.com\/customers\/cus_4Z2ZpyJFuQ0XMb",
      "chartmogul-url": "https:\/\/app.chartmogul.com\/#customers\/25647-Example_Company",
      "billing-system-type": "Stripe",
      "currency": "USD",
      "currency-sign": "\$"
    },
    {
      "id": 74596,
      "uuid": "cus_f466e33d-ff2b-4a11-8f85-417eb02157a7",
      "external_id": "cus_0001",
      "name": "Adam Smith",
      "email": "adam@smith.com",
      "status": "Lead",
      "customer-since": null,
      "attributes": {
        "custom": {
          "channel": "Facebook",
          "age": 18
        },
        "clearbit": {},
        "stripe": {},
        "tags": [
          "important",
          "Prio1"
        ]
      },
      "data_source_uuid": "ds_fef05d54-47b4-431b-aed2-eb6b9e545430",
      "data_source_uuids": [
        "ds_fef05d54-47b4-431b-aed2-eb6b9e545430"
      ],
      "external_ids": [
        "cus_0001"
      ],
      "company": "",
      "country": "US",
      "state": null,
      "city": "New York",
      "zip": null,
      "lead_created_at": "2015-10-14T00:00:00Z",
      "free_trial_started_at": "2015-11-01T00:00:00Z",
      "address": {
        "country": "US",
        "state": null,
        "city": "New York",
        "address_zip": null
      },
      "mrr": 0,
      "arr": 0,
      "billing-system-url": null,
      "chartmogul-url": "https://app.chartmogul.com/#customers/74596-Adam_Smith",
      "billing-system-type": "Import API",
      "currency": "USD",
      "currency-sign": "\$"
    }
  ],
  "has_more": true,
  "per_page": 2,
  "page": 1,
  "current_page": 1,
  "total_pages": 4
}''', 200)));

    final CustomerResults results = await chartMogul.customers.list();

    verify(mockClient.get(customersEndpoint, headers: anyNamed('headers')));

    expect(results.entries.length, equals(2));
    expect(results.page, equals(1));
    expect(results.perPage, equals(2));
    expect(results.hasMore, isTrue);
    expect(results.currentPage, equals(1));
    expect(results.totalPages, equals(4));
  });

  test(
      'list method sends a get request with correct parameters to $customersEndpoint',
      () async {
    when(mockClient.get(
      any,
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('{}', 200)));

    await chartMogul.customers.list(page: 1);
    verify(mockClient.get('$customersEndpoint?page=1',
        headers: anyNamed('headers')));

    await chartMogul.customers.list(externalId: '1a');
    verify(mockClient.get('$customersEndpoint?external_id=1a',
        headers: anyNamed('headers')));

    await chartMogul.customers.list(status: 'Active');
    verify(mockClient.get('$customersEndpoint?status=Active',
        headers: anyNamed('headers')));

    await chartMogul.customers.list(perPage: 3);
    verify(mockClient.get('$customersEndpoint?per_page=3',
        headers: anyNamed('headers')));

    await chartMogul.customers.list(system: 'Stripe');
    verify(mockClient.get('$customersEndpoint?system=Stripe',
        headers: anyNamed('headers')));

    await chartMogul.customers
        .list(dataSourceUuid: 'ds_ab223d54-75b4-431b-adb2-eb6b9e234571');
    verify(mockClient.get(
        '$customersEndpoint?data_source_uuid=ds_ab223d54-75b4-431b-adb2-eb6b9e234571',
        headers: anyNamed('headers')));

    await chartMogul.customers.list(
        page: 1,
        perPage: 2,
        status: 'Lead',
        externalId: '1a',
        dataSourceUuid: 'ds_ab223d54-75b4-431b-adb2-eb6b9e234571');
    final String url =
        verify(mockClient.get(captureAny, headers: anyNamed('headers')))
            .captured
            .single;

    expect(url, startsWith('$customersEndpoint?'));
    expect(url, contains('page=1'));
    expect(url, contains('per_page=2'));
    expect(url, contains('status=Lead'));
    expect(url, contains('external_id=1a'));
    expect(url,
        contains('data_source_uuid=ds_ab223d54-75b4-431b-adb2-eb6b9e234571'));
  });

  test('update method sends a patch request to $customersEndpoint/\$uuid',
      () async {
    const String uuid = 'cus_ab223d54-75b4-431b-adb2-eb6b9e234571';
    const Address address = Address(
      city: 'San Francisco',
      country: 'US',
      state: 'CA',
    );
    const CustomerAttributes attributes = CustomerAttributes(
      tags: <String>['high-value'],
      custom: <String, dynamic>{
        'CAC': 25,
        'channel': <String, dynamic>{
          'value': 'Twitter',
          'source': 'integration2',
        },
      },
    );
    final DateTime leadCreatedAt = DateTime.parse('2015-01-01 00:00:00');
    final DateTime freeTrialStartedAt = DateTime.parse('2015-06-13 15:45:13');

    when(mockClient.patch(
      '$customersEndpoint/$uuid',
      body: anyNamed('body'),
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('''{
    "id": 12150249,
    "uuid": "cus_ab223d54-75b4-431b-adb2-eb6b9e234571",
    "data_source_uuid": "ds_fef05d54-47b4-431b-aed2-eb6b9e545430",
    "data_source_uuids": ["ds_fef05d54-47b4-431b-aed2-eb6b9e545430"],
    "external_id": "34916129",
    "external_ids": ["34916129"],
    "name": "Ben",
    "email": "ben_stiler@examplecompany.com",
    "company": "Example Company",
    "city": "San Francisco",
    "country": "US",
    "state": "CA",
    "zip": "99801",
    "lead_created_at": "2015-01-01T00:00:00.000Z",
    "free_trial_started_at": "2015-06-13T15:45:13.000Z",
    "customer-since": "2015-06-19T13:16:00-04:00",
    "status": "Active",
    "address": {
      "address_zip": "99801",
      "city": "San Francisco",
      "country": "US",
      "state": "CA"
     },
    "attributes": {
      "custom": {
        "CAC": 25,
        "SalesRep": "Mike"
      },
      "clearbit": {},
      "stripe": {},
      "tags": ["high-value"]
    },
    "mrr": 3000,
    "arr": 36000,
    "billing-system-url": "",
    "chartmogul-url": "https:\/\/app.chartmogul.com\/#customers\/12150249-Example_Company",
  	"billing-system-type": "Import API",
  	"currency": "USD",
  	"currency-sign": "\$"
}''', 200)));

    final Customer customer = await chartMogul.customers.update(
      uuid: uuid,
      address: address,
      leadCreatedAt: leadCreatedAt,
      freeTrialStartedAt: freeTrialStartedAt,
      customerAttributes: attributes,
    );

    verify(mockClient.patch(
      '$customersEndpoint/$uuid',
      body: argThat(
          equals(<String, dynamic>{
            'country': address.country,
            'city': address.city,
            'state': address.state,
            'lead_created_at': leadCreatedAt.toIso8601String(),
            'free_trial_started_at': freeTrialStartedAt.toIso8601String(),
            'attributes': <String, dynamic>{
              'tags': <String>['high-value'],
              'custom': <String, dynamic>{
                'CAC': 25,
                'channel': <String, dynamic>{
                  'value': 'Twitter',
                  'source': 'integration2',
                },
              },
            }
          }),
          named: 'body'),
      headers: anyNamed('headers'),
    ));

    expect(customer.id, equals(12150249));
    expect(customer.uuid, equals(uuid));
    expect(customer.externalId, equals('34916129'));
    expect(customer.name, equals('Ben'));
    expect(customer.email, equals('ben_stiler@examplecompany.com'));
    expect(customer.status, equals('Active'));
    expect(
        customer.customerSince, DateTime.tryParse('2015-06-19T13:16:00-04:00'));
    expect(customer.address.zip, equals('99801'));
    expect(customer.address.city, equals(address.city));
    expect(customer.address.state, equals(address.state));
    expect(customer.address.country, equals(address.country));
    expect(customer.dataSourceUuid,
        equals('ds_fef05d54-47b4-431b-aed2-eb6b9e545430'));
    expect(customer.dataSourceUuids,
        equals(<String>['ds_fef05d54-47b4-431b-aed2-eb6b9e545430']));
    expect(customer.externalIds, equals(<String>['34916129']));
    expect(customer.company, equals('Example Company'));
    expect(customer.leadCreatedAt.toIso8601String(),
        contains(leadCreatedAt.toIso8601String()));
    expect(customer.freeTrialStartedAt.toIso8601String(),
        contains(freeTrialStartedAt.toIso8601String()));
    expect(customer.mrr, equals(3000));
    expect(customer.arr, equals(36000));
    expect(customer.billingSystemUrl, equals(''));
    expect(
        customer.chartmogulUrl,
        equals(
            'https:\/\/app.chartmogul.com\/#customers\/12150249-Example_Company'));
    expect(customer.billingSystemType, equals('Import API'));
    expect(customer.currency, equals(currency));
    expect(customer.currencySign, equals(currencySign));
    expect(customer.attributes.tags, equals(attributes.tags));
    expect(customer.attributes.custom,
        equals(<String, dynamic>{'CAC': 25, 'SalesRep': 'Mike'}));
  });
}
