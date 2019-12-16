import 'package:meta/meta.dart';

import '../chartmogul.dart';
import '../models/address.dart';
import '../models/customer.dart';
import '../models/customer_attributes.dart';
import '../util/exceptions.dart';
import '../util/service.dart';

/// Implements Customers endpoints of the ChartMogul Import API and Enrichment API.
///
/// API docs: https://dev.chartmogul.com/reference#customers
class CustomersService implements Service {
  CustomersService(this.client);

  static const String _endpoint = 'customers';
  static const int _maxPerPage = 200;
  static const List<String> _allowedStatuses = <String>[
    'Lead',
    'Active',
    'Past_Due',
    'Cancelled'
  ];

  @override
  ChartMogul client;

  /// Create a new Customer.
  ///
  /// API docs: https://dev.chartmogul.com/reference#create-customer
  Future<Customer> create({
    @required String dataSourceUuid,
    @required String externalId,
    @required String name,
    String email,
    String company,
    Address address,
    DateTime leadCreatedAt,
    DateTime freeTrialStartedAt,
    List<String> tags,
    List<CustomAttribute> customAttributes,
  }) async {
    final Map<String, dynamic> body = <String, dynamic>{
      'data_source_uuid': dataSourceUuid,
      'external_id': externalId,
      'name': name,
    };
    _addMutableFieldsToMap(
      body: body,
      name: name,
      email: email,
      company: company,
      address: address,
      leadCreatedAt: leadCreatedAt,
      freeTrialStartedAt: freeTrialStartedAt,
      tags: tags,
      customAttributes: customAttributes,
    );

    final Map<String, dynamic> response = await client.post(_endpoint, body);
    return Customer.fromJson(response);
  }

  /// Get an existing Customer.
  ///
  /// API docs: https://dev.chartmogul.com/reference#retrieve-customer
  Future<Customer> get(String uuid) async {
    final Map<String, dynamic> response = await client.get('$_endpoint/$uuid');
    return Customer.fromJson(response);
  }

  /// Update an existing Customer.
  ///
  /// API docs: https://dev.chartmogul.com/reference#update-a-customer
  Future<Customer> update({
    @required String uuid,
    String name,
    String email,
    String company,
    Address address,
    DateTime leadCreatedAt,
    DateTime freeTrialStartedAt,
    CustomerAttributes customerAttributes,
  }) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    _addMutableFieldsToMap(
      body: body,
      name: name,
      email: email,
      company: company,
      address: address,
      leadCreatedAt: leadCreatedAt,
      freeTrialStartedAt: freeTrialStartedAt,
      customerAttributes: customerAttributes,
    );

    final Map<String, dynamic> response =
        await client.patch('$_endpoint/$uuid', body);
    return Customer.fromJson(response);
  }

  /// Delete an existing Customer.
  ///
  /// API docs: https://dev.chartmogul.com/reference#delete-a-customer
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

  /// List existing Customers.
  ///
  /// API docs: https://dev.chartmogul.com/reference#list-customers
  Future<CustomerResults> list({
    String dataSourceUuid,
    String externalId,
    String status,
    String system,
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

    if (status != null) {
      if (_allowedStatuses.contains(status)) {
        queryParameters['status'] = status;
      } else {
        throw ClientException(
          'Status $status is not in the allowed list',
          _allowedStatuses.toString(),
        );
      }
    }

    if (system != null) {
      queryParameters['system'] = system;
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

    return CustomerResults.fromJson(response);
  }

  void _addMutableFieldsToMap({
    @required Map<String, dynamic> body,
    String name,
    String email,
    String company,
    Address address,
    DateTime leadCreatedAt,
    DateTime freeTrialStartedAt,
    List<String> tags,
    List<CustomAttribute> customAttributes,
    CustomerAttributes customerAttributes,
  }) {
    if (name != null) {
      body['name'] = name;
    }

    if (email != null) {
      body['email'] = email;
    }

    if (company != null) {
      body['company'] = company;
    }

    if (address != null) {
      if (address.city != null) {
        body['city'] = address.city;
      }
      if (address.state != null) {
        body['state'] = address.state;
      }
      if (address.country != null) {
        body['country'] = address.country;
      }
      if (address.zip != null) {
        body['zip'] = address.zip;
      }
    }

    if (leadCreatedAt != null) {
      body['lead_created_at'] = leadCreatedAt.toIso8601String();
    }

    if (freeTrialStartedAt != null) {
      body['free_trial_started_at'] = freeTrialStartedAt.toIso8601String();
    }

    if (customerAttributes != null) {
      // Only used when creating a new customer.
      body['attributes'] = customerAttributes.toJson();
    } else {
      // Only used when updating an existing customer.
      final Map<String, dynamic> attributes = <String, dynamic>{};
      if (customAttributes != null) {
        attributes['custom'] =
            customAttributes.map((CustomAttribute x) => x.toJson());
      }
      if (tags != null) {
        attributes['tags'] = tags;
      }
      if (attributes.isNotEmpty) {
        body['attributes'] = attributes;
      }
    }
  }
}
