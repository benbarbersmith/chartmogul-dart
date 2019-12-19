import 'package:chartmogul/src/models/invoice.dart';
import 'package:test/test.dart';

const Map<String, dynamic> map = <String, dynamic>{
  'uuid': 'tr_325e460a-1bec-41bb-986e-665e38a1e4cd',
  'external_id': null,
  'type': 'refund',
  'date': '2015-12-25T18:10:00.000Z',
  'result': 'successful'
};

void main() {
  test('Transaction can be created from expected JSON', () {
    final Transaction transaction = Transaction.fromJson(map);

    expect(transaction.uuid, equals(map['uuid']));
    expect(transaction.externalId, isNull);
    expect(transaction.type, equals(TransactionType.refund));
    expect(transaction.result, equals(TransactionResult.successful));
    expect(transaction.date, equals(DateTime.parse(map['date'])));
  });

  test('Valid JSON can be created from Transaction', () {
    final Transaction transaction = Transaction.fromJson(map);
    final Map<String, dynamic> json = transaction.toJson();

    expect(json['uuid'], equals(map['uuid']));
    expect(json['external_id'], equals(map['external_id']));
    expect(json['type'], equals(map['type']));
    expect(json['result'], equals(map['result']));
    expect(json['date'], equals(map['date']));
  });
}
