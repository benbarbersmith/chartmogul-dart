import 'package:chartmogul/chartmogul.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  final MockHttpClient mockClient = MockHttpClient();
  final ChartMogul chartMogul = ChartMogul(
    accountToken: '',
    secretKey: '',
    client: mockClient,
  );

  test('import method sends a post request', () async {
    const String invoiceUuid = 'inv_565c73b2-85b9-49c9-a25e-2b7df6a677c9';
    const String url =
        'https://api.chartmogul.com/v1/import/invoices/$invoiceUuid/transactions';

    const String dateString = '2015-12-25T18:10:00.000Z';
    final DateTime date = DateTime.parse(dateString);

    when(mockClient.post(
      url,
      body: anyNamed('body'),
      headers: anyNamed('headers'),
    )).thenAnswer((_) => Future<http.Response>.value(http.Response('''{
  "uuid": "tr_325e460a-1bec-41bb-986e-665e38a1e4cd",
  "external_id": null,
  "type": "refund",
  "date": "2015-12-25T18:10:00.000Z",
  "result": "successful"
}''', 200)));

    final Transaction transaction = await chartMogul.transactions.import(
      invoiceUuid: invoiceUuid,
      type: TransactionType.refund,
      result: TransactionResult.successful,
      date: date,
    );

    verify(mockClient.post(url,
        body: argThat(
            equals(<String, dynamic>{
              'date': date,
              'type': 'refund',
              'result': 'successful'
            }),
            named: 'body'),
        headers: anyNamed('headers')));

    expect(transaction.uuid, equals('tr_325e460a-1bec-41bb-986e-665e38a1e4cd'));
    expect(transaction.externalId, isNull);
    expect(transaction.type, equals(TransactionType.refund));
    expect(transaction.result, equals(TransactionResult.successful));
    expect(transaction.date, equals(date));
  });
}
