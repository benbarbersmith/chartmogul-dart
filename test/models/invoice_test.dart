import 'package:chartmogul/src/models/invoice.dart';
import 'package:test/test.dart';

void main() {
  const Map<String, dynamic> invoiceMap = <String, dynamic>{
    'uuid': 'inv_565c73b2-85b9-49c9-a25e-2b7df6a677c9',
    'customer_uuid': 'cus_f466e33d-ff2b-4a11-8f85-417eb02157a7',
    'external_id': 'INV0001',
    'date': '2015-11-01T00:00:00.000Z',
    'due_date': '2015-11-15T00:00:00.000Z',
    'currency': 'USD',
    'line_items': <Map<String, dynamic>>[
      <String, dynamic>{
        'uuid': 'li_d72e6843-5793-41d0-bfdf-0269514c9c56',
        'external_id': null,
        'type': 'subscription',
        'subscription_uuid': 'sub_e6bc5407-e258-4de0-bb43-61faaf062035',
        'subscription_external_id': 'sub_0001',
        'subscription_set_external_id': 'set_0001',
        'plan_uuid': 'pl_eed05d54-75b4-431b-adb2-eb6b9e543206',
        'prorated': false,
        'service_period_start': '2015-11-01T00:00:00.000Z',
        'service_period_end': '2015-12-01T00:00:00.000Z',
        'amount_in_cents': 5000,
        'quantity': 1,
        'discount_code': 'PSO86',
        'discount_amount_in_cents': 1000,
        'tax_amount_in_cents': 900,
        'transaction_fees_in_cents': 200,
        'account_code': null
      },
      <String, dynamic>{
        'uuid': 'li_0cc8c112-beac-416d-af11-f35744ca4e83',
        'external_id': null,
        'type': 'one_time',
        'description': 'Setup Fees',
        'amount_in_cents': 2500,
        'quantity': 1,
        'discount_code': 'PSO86',
        'discount_amount_in_cents': 500,
        'tax_amount_in_cents': 450,
        'transaction_fees_in_cents': 0,
        'account_code': null
      }
    ],
    'transactions': <Map<String, dynamic>>[
      <String, dynamic>{
        'uuid': 'tr_879d560a-1bec-41bb-986e-665e38a2f7bc',
        'external_id': null,
        'type': 'payment',
        'date': '2015-11-05T00:14:23.000Z',
        'result': 'successful'
      }
    ]
  };

  test('Invoice can be created from expected JSON', () {
    final Invoice invoice = Invoice.fromJson(invoiceMap);

    expect(invoice.uuid, equals(invoiceMap['uuid']));
    expect(invoice.externalId, equals(invoiceMap['external_id']));
    expect(invoice.customerUuid, equals(invoiceMap['customer_uuid']));
    expect(invoice.currency, equals(invoiceMap['currency']));
    expect(invoice.date, equals(DateTime.parse(invoiceMap['date'])));
    expect(invoice.dueDate, equals(DateTime.parse(invoiceMap['due_date'])));
    expect(invoice.lineItems, isNotEmpty);
    expect(invoice.lineItems.length, equals(2));
    expect(invoice.transactions, isNotEmpty);
    expect(invoice.transactions.length, equals(1));
  });

  test('Valid JSON can be created from Invoice', () {
    final Invoice invoice = Invoice.fromJson(invoiceMap);
    final Map<String, dynamic> json = invoice.toJson();

    expect(json['uuid'], equals(invoiceMap['uuid']));
    expect(json['external_id'], equals(invoiceMap['external_id']));
    expect(json['type'], equals(invoiceMap['type']));
    expect(json['result'], equals(invoiceMap['result']));
    expect(json['date'], equals(invoiceMap['date']));
  });

  const Map<String, dynamic> lineItemMap = <String, dynamic>{
    'uuid': 'li_d72e6843-5793-41d0-bfdf-0269514c9c56',
    'type': 'subscription',
    'subscription_external_id': 'sub_0001',
    'subscription_set_external_id': 'set_0001',
    'plan_uuid': 'pl_eed05d54-75b4-431b-adb2-eb6b9e543206',
    'service_period_start': '2015-11-01 00:00:00',
    'service_period_end': '2015-12-01 00:00:00',
    'amount_in_cents': 5000,
    'quantity': 1,
    'prorated': false,
    'description': 'is descriptive',
    'account_code': 'rd3d3d3',
    'discount_code': 'PSO86',
    'discount_amount_in_cents': 1000,
    'tax_amount_in_cents': 900,
    'transaction_fees_in_cents': 200
  };

  test('LineItem can be created from expected JSON', () {
    final LineItem lineItem = LineItem.fromJson(lineItemMap);

    expect(lineItem.uuid, equals(lineItemMap['uuid']));
    expect(lineItem.type, equals(LineItemType.subscription));
    expect(lineItem.subscriptionExternalId,
        equals(lineItemMap['subscription_external_id']));
    expect(lineItem.subscriptionSetExternalId,
        equals(lineItemMap['subscription_set_external_id']));
    expect(lineItem.planUuid, equals(lineItemMap['plan_uuid']));
    expect(lineItem.servicePeriodStart,
        equals(DateTime.parse(lineItemMap['service_period_start'])));
    expect(lineItem.servicePeriodEnd,
        equals(DateTime.parse(lineItemMap['service_period_end'])));
    expect(lineItem.amountInCents, equals(lineItemMap['amount_in_cents']));
    expect(
        lineItem.taxAmountInCents, equals(lineItemMap['tax_amount_in_cents']));
    expect(lineItem.discountAmountInCents,
        equals(lineItemMap['discount_amount_in_cents']));
    expect(lineItem.transactionFeesInCents,
        equals(lineItemMap['transaction_fees_in_cents']));
    expect(lineItem.discountCode, equals(lineItemMap['discount_code']));
    expect(lineItem.quantity, equals(lineItemMap['quantity']));
    expect(lineItem.accountCode, equals(lineItemMap['account_code']));
    expect(lineItem.prorated, isFalse);
  });

  test('Valid JSON can be created from LineItem', () {
    final LineItem lineItem = LineItem.fromJson(lineItemMap);
    final Map<String, dynamic> json = lineItem.toJson();

    expect(lineItemMap['uuid'], equals(json['uuid']));
    expect(lineItemMap['type'], equals(lineItemMap['type']));
    expect(lineItemMap['subscription_external_id'],
        equals(json['subscription_external_id']));
    expect(lineItemMap['subscription_set_external_id'],
        equals(json['subscription_set_external_id']));
    expect(lineItemMap['plan_uuid'], equals(json['plan_uuid']));
    expect(DateTime.parse(lineItemMap['service_period_start']),
        equals(DateTime.parse(json['service_period_start'])));
    expect(DateTime.parse(lineItemMap['service_period_end']),
        equals(DateTime.parse(json['service_period_end'])));
    expect(lineItemMap['amount_in_cents'], equals(json['amount_in_cents']));
    expect(lineItemMap['tax_amount_in_cents'],
        equals(json['tax_amount_in_cents']));
    expect(lineItemMap['discount_amount_in_cents'],
        equals(json['discount_amount_in_cents']));
    expect(lineItemMap['transaction_fees_in_cents'],
        equals(json['transaction_fees_in_cents']));
    expect(lineItemMap['discount_code'], equals(json['discount_code']));
    expect(lineItemMap['quantity'], equals(json['quantity']));
    expect(lineItemMap['account_code'], equals(json['account_code']));
    expect(lineItemMap['prorated'], equals(json['prorated']));
  });
}
