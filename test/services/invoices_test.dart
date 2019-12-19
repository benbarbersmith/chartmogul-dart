import 'package:chartmogul/chartmogul.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

const String listInvoicesEndpoint = 'https://api.chartmogul.com/v1/invoices';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  final MockHttpClient mockClient = MockHttpClient();
  final ChartMogul chartMogul = ChartMogul(
    accountToken: '',
    secretKey: '',
    client: mockClient,
  );

  test('get method sends a get request to $listInvoicesEndpoint/\$uuid',
      () async {
    const String uuid = 'inv_565c73b2-85b9-49c9-a25e-2b7df6a677c9';
    const String url = '$listInvoicesEndpoint/$uuid';

    when(mockClient.get(
      url,
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('''{
      "uuid": "inv_565c73b2-85b9-49c9-a25e-2b7df6a677c9",
      "customer_uuid": "cus_f466e33d-ff2b-4a11-8f85-417eb02157a7",
      "external_id": "INV0001",
      "date": "2015-11-01T00:00:00.000Z",
      "due_date": "2015-11-15T00:00:00.000Z",
      "currency": "USD",
      "line_items": [
        {
          "uuid": "li_d72e6843-5793-41d0-bfdf-0269514c9c56",
          "external_id": null,
          "type": "subscription",
          "subscription_uuid": "sub_e6bc5407-e258-4de0-bb43-61faaf062035",
          "subscription_external_id": "sub_0001",
          "subscription_set_external_id": "set_0001",
          "plan_uuid": "pl_eed05d54-75b4-431b-adb2-eb6b9e543206",
          "prorated": false,
          "service_period_start": "2015-11-01T00:00:00.000Z",
          "service_period_end": "2015-12-01T00:00:00.000Z",
          "amount_in_cents": 5000,
          "quantity": 1,
          "discount_code": "PSO86",
          "discount_amount_in_cents": 1000,
          "tax_amount_in_cents": 900,
          "transaction_fees_in_cents": 200,
          "account_code": null
        },
        {
          "uuid": "li_0cc8c112-beac-416d-af11-f35744ca4e83",
          "external_id": null,
          "type": "one_time",
          "description": "Setup Fees",
          "amount_in_cents": 2500,
          "quantity": 1,
          "discount_code": "PSO86",
          "discount_amount_in_cents": 500,
          "tax_amount_in_cents": 450,
          "transaction_fees_in_cents": 0,
          "account_code": null
        }
      ],
      "transactions": [
        {
          "uuid": "tr_879d560a-1bec-41bb-986e-665e38a2f7bc",
          "external_id": null,
          "type": "payment",
          "date": "2015-11-05T00:14:23.000Z",
          "result": "successful"
        }
      ]
}''', 200)));

    final Invoice invoice = await chartMogul.invoices.get(uuid);

    verify(mockClient.get(url, headers: anyNamed('headers')));

    expect(invoice.uuid, equals('inv_565c73b2-85b9-49c9-a25e-2b7df6a677c9'));
    expect(invoice.externalId, equals('INV0001'));
    expect(invoice.customerUuid,
        equals('cus_f466e33d-ff2b-4a11-8f85-417eb02157a7'));
    expect(invoice.currency, equals('USD'));
    expect(invoice.date, equals(DateTime.parse('2015-11-01T00:00:00.000Z')));
    expect(invoice.dueDate, equals(DateTime.parse('2015-11-15T00:00:00.000Z')));
    expect(invoice.lineItems.length, equals(2));
    final List<LineItem> oneTimeLineItems = invoice.lineItems
        .where((LineItem l) => l.type == LineItemType.one_time)
        .toList();
    expect(oneTimeLineItems, isNotEmpty);
    expect(oneTimeLineItems.length, equals(1));
    expect(oneTimeLineItems.first.uuid,
        equals('li_0cc8c112-beac-416d-af11-f35744ca4e83'));
    final List<LineItem> subscriptionLineItems = invoice.lineItems
        .where((LineItem l) => l.type == LineItemType.subscription)
        .toList();
    expect(subscriptionLineItems, isNotNull);
    expect(subscriptionLineItems.length, equals(1));
    expect(subscriptionLineItems.first.uuid,
        equals('li_d72e6843-5793-41d0-bfdf-0269514c9c56'));
  });

  test('list method sends a get request to $listInvoicesEndpoint', () async {
    when(mockClient.get(
      listInvoicesEndpoint,
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('''{
  "invoices": [
    {
      "uuid": "inv_565c73b2-85b9-49c9-a25e-2b7df6a677c9",
      "customer_uuid": "cus_f466e33d-ff2b-4a11-8f85-417eb02157a7",
      "external_id": "INV0001",
      "date": "2015-11-01T00:00:00.000Z",
      "due_date": "2015-11-15T00:00:00.000Z",
      "currency": "USD",
      "line_items": [
        {
          "uuid": "li_d72e6843-5793-41d0-bfdf-0269514c9c56",
          "external_id": null,
          "type": "subscription",
          "subscription_uuid": "sub_e6bc5407-e258-4de0-bb43-61faaf062035",
          "subscription_external_id": "sub_0001",
          "subscription_set_external_id": "set_0001",
          "plan_uuid": "pl_eed05d54-75b4-431b-adb2-eb6b9e543206",
          "prorated": false,
          "service_period_start": "2015-11-01T00:00:00.000Z",
          "service_period_end": "2015-12-01T00:00:00.000Z",
          "amount_in_cents": 5000,
          "quantity": 1,
          "discount_code": "PSO86",
          "discount_amount_in_cents": 1000,
          "tax_amount_in_cents": 900,
          "transaction_fees_in_cents": 200,
          "account_code": null
        },
        {
          "uuid": "li_0cc8c112-beac-416d-af11-f35744ca4e83",
          "external_id": null,
          "type": "one_time",
          "description": "Setup Fees",
          "amount_in_cents": 2500,
          "quantity": 1,
          "discount_code": "PSO86",
          "discount_amount_in_cents": 500,
          "tax_amount_in_cents": 450,
          "transaction_fees_in_cents": 0,
          "account_code": null
        }
      ],
      "transactions": [
        {
          "uuid": "tr_879d560a-1bec-41bb-986e-665e38a2f7bc",
          "external_id": null,
          "type": "payment",
          "date": "2015-11-05T00:14:23.000Z",
          "result": "successful"
        }
      ]
    }
  ],
  "current_page": 1,
  "total_pages": 1
}''', 200)));

    final InvoiceResults results = await chartMogul.invoices.list();

    verify(mockClient.get(listInvoicesEndpoint, headers: anyNamed('headers')));

    expect(results.entries.length, equals(1));
    expect(results.currentPage, equals(1));
    expect(results.totalPages, equals(1));

    final Invoice invoice = results.entries.first;
    expect(invoice.uuid, equals('inv_565c73b2-85b9-49c9-a25e-2b7df6a677c9'));
    expect(invoice.externalId, equals('INV0001'));
    expect(invoice.customerUuid,
        equals('cus_f466e33d-ff2b-4a11-8f85-417eb02157a7'));
    expect(invoice.currency, equals('USD'));
    expect(invoice.date, equals(DateTime.parse('2015-11-01T00:00:00.000Z')));
    expect(invoice.dueDate, equals(DateTime.parse('2015-11-15T00:00:00.000Z')));
    expect(invoice.lineItems.length, equals(2));
    final List<LineItem> oneTimeLineItems = invoice.lineItems
        .where((LineItem l) => l.type == LineItemType.one_time)
        .toList();
    expect(oneTimeLineItems, isNotEmpty);
    expect(oneTimeLineItems.length, equals(1));
    expect(oneTimeLineItems.first.uuid,
        equals('li_0cc8c112-beac-416d-af11-f35744ca4e83'));
    final List<LineItem> subscriptionLineItems = invoice.lineItems
        .where((LineItem l) => l.type == LineItemType.subscription)
        .toList();
    expect(subscriptionLineItems, isNotNull);
    expect(subscriptionLineItems.length, equals(1));
    expect(subscriptionLineItems.first.uuid,
        equals('li_d72e6843-5793-41d0-bfdf-0269514c9c56'));
  });

  test(
      'list method sends a get request to https://api.chartmogul.com/v1/import/customers/\$customerUuid/invoices',
      () async {
    const String url =
        'https://api.chartmogul.com/v1/import/customers/cus_f466e33d-ff2b-4a11-8f85-417eb02157a7/invoices';

    when(mockClient.get(
      url,
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('''{
  "customer_uuid": "cus_f466e33d-ff2b-4a11-8f85-417eb02157a7",
  "invoices": [
    {
      "uuid": "inv_565c73b2-85b9-49c9-a25e-2b7df6a677c9",
      "customer_uuid": "cus_f466e33d-ff2b-4a11-8f85-417eb02157a7",
      "external_id": "INV0001",
      "date": "2015-11-01T00:00:00.000Z",
      "due_date": "2015-11-15T00:00:00.000Z",
      "currency": "USD",
      "line_items": [
        {
          "uuid": "li_d72e6843-5793-41d0-bfdf-0269514c9c56",
          "external_id": null,
          "type": "subscription",
          "subscription_uuid": "sub_e6bc5407-e258-4de0-bb43-61faaf062035",
          "subscription_external_id": "sub_0001",
          "subscription_set_external_id": "set_0001",
          "plan_uuid": "pl_eed05d54-75b4-431b-adb2-eb6b9e543206",
          "prorated": false,
          "service_period_start": "2015-11-01T00:00:00.000Z",
          "service_period_end": "2015-12-01T00:00:00.000Z",
          "amount_in_cents": 5000,
          "quantity": 1,
          "discount_code": "PSO86",
          "discount_amount_in_cents": 1000,
          "tax_amount_in_cents": 900,
          "transaction_fees_in_cents": 200,
          "account_code": null
        },
        {
          "uuid": "li_0cc8c112-beac-416d-af11-f35744ca4e83",
          "external_id": null,
          "type": "one_time",
          "description": "Setup Fees",
          "amount_in_cents": 2500,
          "quantity": 1,
          "discount_code": "PSO86",
          "discount_amount_in_cents": 500,
          "tax_amount_in_cents": 450,
          "transaction_fees_in_cents": 0,
          "account_code": null
        }
      ],
      "transactions": [
        {
          "uuid": "tr_879d560a-1bec-41bb-986e-665e38a2f7bc",
          "external_id": null,
          "type": "payment",
          "date": "2015-11-05T00:14:23.000Z",
          "result": "successful"
        }
      ]
    }
  ],
  "current_page": 1,
  "total_pages": 1
}''', 200)));

    final InvoiceResults results = await chartMogul.invoices.listForCustomer(
        customerUuid: 'cus_f466e33d-ff2b-4a11-8f85-417eb02157a7');

    verify(mockClient.get(url, headers: anyNamed('headers')));

    expect(results.customerUuid,
        equals('cus_f466e33d-ff2b-4a11-8f85-417eb02157a7'));
    expect(results.entries.length, equals(1));
    expect(results.currentPage, equals(1));
    expect(results.totalPages, equals(1));

    final Invoice invoice = results.entries.first;
    expect(invoice.uuid, equals('inv_565c73b2-85b9-49c9-a25e-2b7df6a677c9'));
    expect(invoice.externalId, equals('INV0001'));
    expect(invoice.customerUuid,
        equals('cus_f466e33d-ff2b-4a11-8f85-417eb02157a7'));
    expect(invoice.currency, equals('USD'));
    expect(invoice.date, equals(DateTime.parse('2015-11-01T00:00:00.000Z')));
    expect(invoice.dueDate, equals(DateTime.parse('2015-11-15T00:00:00.000Z')));
    expect(invoice.lineItems.length, equals(2));
    final List<LineItem> oneTimeLineItems = invoice.lineItems
        .where((LineItem l) => l.type == LineItemType.one_time)
        .toList();
    expect(oneTimeLineItems, isNotEmpty);
    expect(oneTimeLineItems.length, equals(1));
    expect(oneTimeLineItems.first.uuid,
        equals('li_0cc8c112-beac-416d-af11-f35744ca4e83'));
    final List<LineItem> subscriptionLineItems = invoice.lineItems
        .where((LineItem l) => l.type == LineItemType.subscription)
        .toList();
    expect(subscriptionLineItems, isNotNull);
    expect(subscriptionLineItems.length, equals(1));
    expect(subscriptionLineItems.first.uuid,
        equals('li_d72e6843-5793-41d0-bfdf-0269514c9c56'));
  });

  test(
      'list method sends a get request with correct parameters to $listInvoicesEndpoint',
      () async {
    when(mockClient.get(
      any,
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('{}', 200)));

    await chartMogul.invoices.list(customerUuid: 'abc1');
    verify(mockClient.get('$listInvoicesEndpoint?customer_uuid=abc1',
        headers: anyNamed('headers')));

    await chartMogul.invoices.list(dataSourceUuid: 'abcd1');
    verify(mockClient.get('$listInvoicesEndpoint?data_source_uuid=abcd1',
        headers: anyNamed('headers')));

    await chartMogul.invoices.list(externalId: 'abcde1');
    verify(mockClient.get('$listInvoicesEndpoint?external_id=abcde1',
        headers: anyNamed('headers')));

    await chartMogul.invoices.list(page: 1);
    verify(mockClient.get('$listInvoicesEndpoint?page=1',
        headers: anyNamed('headers')));

    await chartMogul.invoices.list(page: 1);
    verify(mockClient.get('$listInvoicesEndpoint?page=1',
        headers: anyNamed('headers')));

    await chartMogul.invoices.list(perPage: 3);
    verify(mockClient.get('$listInvoicesEndpoint?per_page=3',
        headers: anyNamed('headers')));

    await chartMogul.invoices.list(
        customerUuid: 'abc1',
        externalId: 'abcde1',
        dataSourceUuid: 'abcd1',
        page: 1,
        perPage: 2);
    final String url =
        verify(mockClient.get(captureAny, headers: anyNamed('headers')))
            .captured
            .single;

    expect(url, startsWith('$listInvoicesEndpoint?'));
    expect(url, contains('page=1'));
    expect(url, contains('per_page=2'));
    expect(url, contains('data_source_uuid=abcd1'));
    expect(url, contains('external_id=abcde1'));
    expect(url, contains('customer_uuid=abc1'));
  });

  test('delete method sends a delete request to $listInvoicesEndpoint/\$uuid',
      () async {
    const String uuid = 'inv_ee325d54-7ab4-421b-cdb2-eb6b9e546034';
    const String url = 'https://api.chartmogul.com/v1/invoices/$uuid';

    final http.Response emptyResponse = http.Response('{}', 200);
    when(mockClient.delete(
      url,
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(emptyResponse));

    await chartMogul.invoices.delete(uuid);
    verify(mockClient.delete(url, headers: anyNamed('headers')));
  });

  test('import method sends a post request', () async {
    const String customerUuid = 'cus_f466e33d-ff2b-4a11-8f85-417eb02157a7';
    const String url =
        'https://api.chartmogul.com/v1/import/customers/$customerUuid/invoices';

    when(mockClient.post(
      url,
      body: anyNamed('body'),
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('''{
  "invoices": [
    {
      "uuid": "inv_565c73b2-85b9-49c9-a25e-2b7df6a677c9",
      "external_id": "INV0001",
      "date": "2015-11-01T00:00:00.000Z",
      "due_date": "2015-11-15T00:00:00.000Z",
      "currency": "USD",
      "line_items": [
        {
          "uuid": "li_d72e6843-5793-41d0-bfdf-0269514c9c56",
          "external_id": null,
          "type": "subscription",
          "subscription_uuid": "sub_e6bc5407-e258-4de0-bb43-61faaf062035",
          "subscription_external_id": "sub_0001",
          "subscription_set_external_id": "set_0001",
          "plan_uuid": "pl_eed05d54-75b4-431b-adb2-eb6b9e543206",
          "prorated": false,
          "service_period_start": "2015-11-01T00:00:00.000Z",
          "service_period_end": "2015-12-01T00:00:00.000Z",
          "amount_in_cents": 5000,
          "quantity": 1,
          "discount_code": "PSO86",
          "discount_amount_in_cents": 1000,
          "tax_amount_in_cents": 900,
          "transaction_fees_in_cents": 200,
          "account_code": null
        },
        {
          "uuid": "li_0cc8c112-beac-416d-af11-f35744ca4e83",
          "external_id": null,
          "type": "one_time",
          "description": "Setup Fees",
          "amount_in_cents": 2500,
          "quantity": 1,
          "discount_code": "PSO86",
          "discount_amount_in_cents": 500,
          "tax_amount_in_cents": 450,
          "transaction_fees_in_cents": 0,
          "account_code": null
        }
      ],
      "transactions": [
        {
          "uuid": "tr_879d560a-1bec-41bb-986e-665e38a2f7bc",
          "external_id": null,
          "type": "payment",
          "date": "2015-11-05T00:14:23.000Z",
          "result": "successful"
        }
      ]
    }
  ]
}''', 200)));

    final List<Invoice> inputInvoices = <Invoice>[
      Invoice(
        externalId: 'INV0001',
        currency: 'USD',
        date: DateTime.parse('2015-11-01 00:00:00'),
        dueDate: DateTime.parse('2015-11-15 00:00:00'),
        lineItems: <LineItem>[
          LineItem(
            type: LineItemType.subscription,
            subscriptionExternalId: 'sub_0001',
            subscriptionSetExternalId: 'set_0001',
            planUuid: 'pl_eed05d54-75b4-431b-adb2-eb6b9e543206',
            servicePeriodStart: DateTime.parse('2015-11-01 00:00:00'),
            servicePeriodEnd: DateTime.parse('2015-12-01 00:00:00'),
            amountInCents: 5000,
            quantity: 1,
            discountCode: 'PSO86',
            discountAmountInCents: 1000,
            taxAmountInCents: 900,
            transactionFeesInCents: 200,
          ),
          const LineItem(
            type: LineItemType.one_time,
            description: 'Setup Fees',
            amountInCents: 2500,
            quantity: 1,
            discountCode: 'PSO86',
            discountAmountInCents: 500,
            taxAmountInCents: 450,
          )
        ],
        transactions: <Transaction>[
          Transaction(
            date: DateTime.parse('2015-11-05 00:14:23'),
            type: TransactionType.payment,
            result: TransactionResult.successful,
          )
        ],
      ),
    ];

    final List<Invoice> responseInvoices = await chartMogul.invoices.import(
      customerUuid: customerUuid,
      invoices: inputInvoices,
    );

    final Map<String, dynamic> invoiceMap = verify(mockClient.post(
      url,
      body: captureAnyNamed('body'),
      headers: anyNamed('headers'),
    )).captured.single;

    expect(
        invoiceMap,
        equals(<String, dynamic>{
          'invoices': <Map<String, dynamic>>[
            <String, dynamic>{
              'external_id': 'INV0001',
              'date': DateTime.parse('2015-11-01 00:00:00').toIso8601String(),
              'currency': 'USD',
              'due_date':
                  DateTime.parse('2015-11-15 00:00:00').toIso8601String(),
              'line_items': <Map<String, dynamic>>[
                <String, dynamic>{
                  'type': 'subscription',
                  'subscription_external_id': 'sub_0001',
                  'subscription_set_external_id': 'set_0001',
                  'plan_uuid': 'pl_eed05d54-75b4-431b-adb2-eb6b9e543206',
                  'service_period_start':
                      DateTime.parse('2015-11-01 00:00:00').toIso8601String(),
                  'service_period_end':
                      DateTime.parse('2015-12-01 00:00:00').toIso8601String(),
                  'amount_in_cents': 5000,
                  'quantity': 1,
                  'discount_code': 'PSO86',
                  'discount_amount_in_cents': 1000,
                  'tax_amount_in_cents': 900,
                  'transaction_fees_in_cents': 200
                },
                <String, dynamic>{
                  'type': 'one_time',
                  'description': 'Setup Fees',
                  'amount_in_cents': 2500,
                  'quantity': 1,
                  'discount_code': 'PSO86',
                  'discount_amount_in_cents': 500,
                  'tax_amount_in_cents': 450
                }
              ],
              'transactions': <Map<String, dynamic>>[
                <String, dynamic>{
                  'date':
                      DateTime.parse('2015-11-05 00:14:23').toIso8601String(),
                  'type': 'payment',
                  'result': 'successful'
                }
              ]
            }
          ]
        }));

    final Invoice invoice = responseInvoices.single;
    expect(invoice.uuid, equals('inv_565c73b2-85b9-49c9-a25e-2b7df6a677c9'));
    expect(invoice.externalId, equals('INV0001'));
    expect(invoice.currency, equals('USD'));
    expect(invoice.date, equals(DateTime.parse('2015-11-01T00:00:00.000Z')));
    expect(invoice.dueDate, equals(DateTime.parse('2015-11-15T00:00:00.000Z')));
  });
}
