import 'package:meta/meta.dart';

import '../chartmogul.dart';
import '../models/subscription.dart';
import '../util/exceptions.dart';
import '../util/service.dart';

/// Implements Subscriptions endpoints of the ChartMogul Import API.
///
/// API docs: https://dev.chartmogul.com/reference#subscriptions
class SubscriptionsService implements Service {
  SubscriptionsService(this.client);

  static const int _maxPerPage = 200;

  @override
  ChartMogul client;

  /// Cancel an existing Subscription.
  ///
  /// API docs: https://dev.chartmogul.com/reference#cancel-a-customers-subscription
  Future<Subscription> cancel({
    @required String uuid,
    DateTime cancelledAt,
    List<DateTime> cancellationDates,
  }) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    if (cancelledAt != null) {
      body['cancelled_at'] = cancelledAt.toIso8601String();
    }
    if (cancellationDates != null) {
      body['cancellation_dates'] =
          cancellationDates.map((DateTime d) => d.toIso8601String()).toList();
    }
    final Map<String, dynamic> response =
        await client.patch('import/subscriptions/$uuid', body);
    return Subscription.fromJson(response);
  }

  /// List existing Subscriptions for a customer.
  ///
  /// API docs: https://dev.chartmogul.com/reference#list-a-customers-subscriptions
  Future<SubscriptionResults> list({
    @required String customerUuid,
    int page,
    int perPage,
  }) async {
    final String endpoint = 'import/customers/$customerUuid/subscriptions';
    final Map<String, String> queryParameters = <String, String>{};
    if (page != null) {
      queryParameters['page'] = '$page';
    }
    if (perPage != null) {
      if (perPage <= _maxPerPage) {
        queryParameters['per_page'] = '$perPage';
      } else {
        throw ClientException(
          'Maximum results per page is 200, which is less than',
          perPage.toString(),
        );
      }
    }

    Map<String, dynamic> response;

    if (queryParameters.isNotEmpty) {
      response = await client.get(
        endpoint,
        queryParameters: queryParameters,
      );
    } else {
      response = await client.get(endpoint);
    }

    return SubscriptionResults.fromJson(response);
  }
}
