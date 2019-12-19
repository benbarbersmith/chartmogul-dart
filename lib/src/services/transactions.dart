import 'package:meta/meta.dart';

import '../chartmogul.dart';
import '../models/invoice.dart';
import '../util/service.dart';

/// Implements Transactions endpoints of the ChartMogul Import API.
///
/// API docs: https://dev.chartmogul.com/reference#transactions
class TransactionsService implements Service {
  TransactionsService(this.client);

  @override
  ChartMogul client;

  /// Import a transaction for an existing Invoice.
  ///
  /// API docs: https://dev.chartmogul.com/reference#transactions
  Future<Transaction> import({
    @required String invoiceUuid,
    @required TransactionType type,
    @required DateTime date,
    @required TransactionResult result,
    String externalId,
  }) async {
    final Map<String, dynamic> body = <String, dynamic>{
      'date': date,
      'result': result.toString().split('.').last,
      'type': type.toString().split('.').last,
    };

    if (externalId != null) {
      body['external_id'] = externalId;
    }

    final Map<String, dynamic> response = await client.post(
      'import/invoices/$invoiceUuid/transactions',
      body,
    );
    return Transaction.fromJson(response);
  }
}
