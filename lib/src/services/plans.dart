import 'package:meta/meta.dart';

import '../chartmogul.dart';
import '../models/plan.dart';
import '../util/exceptions.dart';
import '../util/service.dart';

/// Implements Plans endpoints of the ChartMogul Import API.
///
/// API docs: https://dev.chartmogul.com/reference#plans
class PlansService implements Service {
  PlansService(this.client);

  static const String _endpoint = 'plans';
  static const int _maxPerPage = 200;

  @override
  ChartMogul client;

  /// Create a new Plan.
  ///
  /// API docs: https://dev.chartmogul.com/reference#create-plan
  Future<Plan> create({
    @required String dataSourceUuid,
    @required String name,
    @required int intervalCount,
    @required String intervalUnit,
    String externalId,
  }) async {
    final Map<String, dynamic> response = await client.post(
      _endpoint,
      Plan(
        dataSourceUuid: dataSourceUuid,
        name: name,
        intervalCount: intervalCount,
        intervalUnit: intervalUnit,
        externalId: externalId,
      ).toJson(),
    );
    return Plan.fromJson(response);
  }

  /// Get an existing Plan.
  ///
  /// API docs: https://dev.chartmogul.com/reference#retrieve-a-plan
  Future<Plan> get(String uuid) async {
    final Map<String, dynamic> response = await client.get('$_endpoint/$uuid');
    return Plan.fromJson(response);
  }

  /// Update an existing Plan.
  ///
  /// API docs: https://dev.chartmogul.com/reference#update-a-plan
  Future<Plan> update({
    @required String uuid,
    String name,
    int intervalCount,
    String intervalUnit,
  }) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    if (name != null) {
      body['name'] = name;
    }
    if (intervalCount != null) {
      body['interval_count'] = intervalCount;
    }
    if (intervalUnit != null) {
      body['interval_unit'] = intervalUnit;
    }
    final Map<String, dynamic> response =
        await client.patch('$_endpoint/$uuid', body);
    return Plan.fromJson(response);
  }

  /// Delete an existing Plan.
  ///
  /// API docs: https://dev.chartmogul.com/reference#delete-a-plan
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

  /// List existing Plans.
  ///
  /// API docs: https://dev.chartmogul.com/reference#list-plans
  Future<PlanResults> list({
    String dataSourceUuid,
    String externalId,
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

    return PlanResults.fromJson(response);
  }
}
