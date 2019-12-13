import 'package:chartmogul/src/models/customer.dart';
import 'package:test/test.dart';

const Map<String, dynamic> map = <String, dynamic>{
  'id': 25647,
  'uuid': 'cus_de305d54-75b4-431b-adb2-eb6b9e546012',
  'external_id': '34916129',
  'name': 'Example Company',
  'email': 'bob@examplecompany.com',
  'status': 'Active',
  'customer-since': '2015-06-09T13:16:00-04:00',
  'attributes': <String, dynamic>{
    'tags': <String>['engage', 'unit loss', 'discountable'],
    'stripe': <String, dynamic>{'uid': 7, 'coupon': true},
    'clearbit': <String, dynamic>{
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
    },
    'custom': <String, dynamic>{
      'CAC': 213,
      'utmCampaign': 'social media 1',
      'convertedAt': '2015-09-08 00:00:00',
      'pro': false,
      'salesRep': 'Gabi'
    }
  },
  'address': <String, dynamic>{
    'address_zip': '0185128',
    'city': 'Nowhereville',
    'state': 'Alaska',
    'country': 'US'
  },
  'data_source_uuid': 'ds_fef05d54-47b4-431b-aed2-eb6b9e545430',
  'data_source_uuids': <String>['ds_fef05d54-47b4-431b-aed2-eb6b9e545430'],
  'external_ids': <String>['34916129'],
  'company': '',
  'country': 'US',
  'state': 'Alaska',
  'city': 'Nowhereville',
  'zip': '0185128',
  'lead_created_at': null,
  'free_trial_started_at': null,
  'mrr': 3000,
  'arr': 36000,
  'billing-system-url':
      'https:\/\/dashboard.stripe.com\/customers\/cus_4Z2ZpyJFuQ0XMb',
  'chartmogul-url':
      'https:\/\/app.chartmogul.com\/#customers\/25647-Example_Company',
  'billing-system-type': 'Stripe',
  'currency': 'USD',
  'currency-sign': '\$'
};

void main() {
  test('Customer can be created from expected JSON', () {
    final Customer customer = Customer.fromJson(map);

    expect(customer.id, equals(map['id']));
    expect(customer.uuid, equals(map['uuid']));
    expect(customer.externalId, equals(map['external_id']));
    expect(customer.name, equals(map['name']));
    expect(customer.email, equals(map['email']));
    expect(customer.status, equals(map['status']));
    expect(
        customer.customerSince, equals(DateTime.parse(map['customer-since'])));
    expect(customer.address.zip, equals(map['address']['address_zip']));
    expect(customer.address.city, equals(map['address']['city']));
    expect(customer.address.state, equals(map['address']['state']));
    expect(customer.address.country, equals(map['address']['country']));
    expect(customer.dataSourceUuid, equals(map['data_source_uuid']));
    expect(customer.dataSourceUuids, equals(map['data_source_uuids']));
    expect(customer.externalIds, equals(map['external_ids']));
    expect(customer.company, equals(map['company']));
    expect(customer.leadCreatedAt, equals(isNull));
    expect(customer.freeTrialStartedAt, isNull);
    expect(customer.mrr, equals(map['mrr']));
    expect(customer.arr, equals(map['arr']));
    expect(customer.billingSystemUrl, equals(map['billing-system-url']));
    expect(customer.chartmogulUrl, equals(map['chartmogul-url']));
    expect(customer.billingSystemType, equals(map['billing-system-type']));
    expect(customer.currency, equals(map['currency']));
    expect(customer.currencySign, equals(map['currency-sign']));
  });

  test('Valid JSON can be created from customer', () {
    final Customer customer = Customer.fromJson(map);
    final Map<String, dynamic> json = customer.toJson();

    expect(json['id'], equals(map['id']));
    expect(json['uuid'], equals(map['uuid']));
    expect(json['external_id'], equals(map['external_id']));
    expect(json['name'], equals(map['name']));
    expect(json['email'], equals(map['email']));
    expect(json['status'], equals(map['status']));
    expect(DateTime.parse(json['customer-since']),
        equals(DateTime.parse(map['customer-since'])));
    expect(
        json['address']['address_zip'], equals(map['address']['address_zip']));
    expect(json['address']['city'], equals(map['address']['city']));
    expect(json['address']['state'], equals(map['address']['state']));
    expect(json['address']['country'], equals(map['address']['country']));
    expect(json['data_source_uuid'], equals(map['data_source_uuid']));
    expect(json['data_source_uuids'], equals(map['data_source_uuids']));
    expect(json['external_ids'], equals(map['external_ids']));
    expect(json['company'], equals(map['company']));
    expect(json['lead_created_at'], equals(map['lead_created_at']));
    expect(json['free_trial_started_at'], equals(map['free_trial_started_at']));
    expect(json['mrr'], equals(map['mrr']));
    expect(json['arr'], equals(map['arr']));
    expect(json['billing-system-url'], equals(map['billing-system-url']));
    expect(json['chartmogul-url'], equals(map['chartmogul-url']));
    expect(json['billing-system-type'], equals(map['billing-system-type']));
    expect(json['currency'], equals(map['currency']));
    expect(json['currency-sign'], equals(map['currency-sign']));
  });
}
