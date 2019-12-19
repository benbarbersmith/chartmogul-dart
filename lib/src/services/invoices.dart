import 'package:meta/meta.dart';

import '../chartmogul.dart';
import '../models/invoice.dart';
import '../util/exceptions.dart';
import '../util/service.dart';

/// Implements Invoices endpoints of the ChartMogul Import API.
///
/// API docs: https://dev.chartmogul.com/reference#invoices
class InvoicesService implements Service {
  InvoicesService(this.client);

  static const String _endpoint = 'invoices';
  static const int _maxPerPage = 200;

  @override
  ChartMogul client;

  /// Create new Invoices.
  ///
  /// API docs: https://dev.chartmogul.com/reference#import-customers-invoices
  Future<List<Invoice>> import({
    @required String customerUuid,
    @required List<Invoice> invoices,
  }) async {
    final Map<String, dynamic> body = <String, dynamic>{
      'invoices': invoices.map((Invoice invoice) => invoice.toJson()).toList(),
    };

    final Map<String, dynamic> response = await client.post(
      'import/customers/$customerUuid/invoices',
      body,
    );

    if (!response.containsKey('invoices')) {
      throw MalformedResponseException(
        'Expected response to contain field "invoices"',
        response.toString(),
      );
    }

    final List<dynamic> invoiceMaps = response['invoices'];
    return invoiceMaps
        .whereType<Map<String, dynamic>>()
        .map((dynamic json) => Invoice.fromJson(json))
        .toList();
  }

  /// Get an existing Invoice.
  ///
  /// API docs: https://dev.chartmogul.com/reference#retrieve-an-invoice
  Future<Invoice> get(String uuid) async {
    final Map<String, dynamic> response = await client.get('$_endpoint/$uuid');
    return Invoice.fromJson(response);
  }

  /// Delete an existing Invoice.
  ///
  /// API docs: https://dev.chartmogul.com/reference#delete-an-invoice
  Future<void> delete(String uuid) async {
    final Map<String, dynamic> response =
        await client.delete('$_endpoint/$uuid');

    // If we get a OK response, the body always should be an empty map.
    if (response.isNotEmpty) {
      throw MalformedResponseException(
        'We received a 2XX response code and valid JSON '
        'but it contained an unexpected payload.',
        response.toString(),
      );
    }
  }

  /// List existing Invoices.
  ///
  /// API docs: https://dev.chartmogul.com/reference#list-invoices
  Future<InvoiceResults> list({
    String dataSourceUuid,
    String externalId,
    String customerUuid,
    int page,
    int perPage,
  }) async {
    final Map<String, String> queryParameters = <String, String>{};

    if (dataSourceUuid != null) {
      queryParameters['data_source_uuid'] = dataSourceUuid;
    }

    if (externalId != null) {
      queryParameters['external_id'] = externalId;
    }

    if (customerUuid != null) {
      queryParameters['customer_uuid'] = customerUuid;
    }

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
        _endpoint,
        queryParameters: queryParameters,
      );
    } else {
      response = await client.get(_endpoint);
    }

    return InvoiceResults.fromJson(response);
  }

  /// List existing Invoices for a customer.
  ///
  /// API docs: https://dev.chartmogul.com/reference#list-customers-invoices
  Future<InvoiceResults> listForCustomer({
    @required String customerUuid,
    int page,
    int perPage,
  }) async {
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

    final String endpoint = 'import/customers/$customerUuid/invoices';
    Map<String, dynamic> response;

    if (queryParameters.isNotEmpty) {
      response = await client.get(
        endpoint,
        queryParameters: queryParameters,
      );
    } else {
      response = await client.get(endpoint);
    }

    return InvoiceResults.fromJson(response);
  }
}
