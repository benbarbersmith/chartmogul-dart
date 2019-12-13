import '../chartmogul.dart';
import '../models/data_source.dart';
import '../util/exceptions.dart';
import '../util/service.dart';

/// Implements DataSource endpoints of the ChartMogul Import API.
///
/// API docs: https://dev.chartmogul.com/reference#data-sources
class DataSourcesService implements Service {
  DataSourcesService(this.client);

  static const String _endpoint = 'data_sources';

  @override
  ChartMogul client;

  /// Create a new Data Source.
  ///
  /// API docs: https://dev.chartmogul.com/reference#create-data-source
  Future<DataSource> create(String name) async {
    final Map<String, dynamic> response = await client.post(
      _endpoint,
      <String, dynamic>{'name': name},
    );
    return DataSource.fromJson(response);
  }

  /// Get an existing Data Source.
  ///
  /// API docs: https://dev.chartmogul.com/reference#retrieve-a-data-source
  Future<DataSource> get(String uuid) async {
    final Map<String, dynamic> response = await client.get('$_endpoint/$uuid');
    return DataSource.fromJson(response);
  }

  /// Delete an existing Data Source.
  ///
  /// API docs: https://dev.chartmogul.com/reference#delete-a-data-source
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

  /// List existing Data Sources.
  ///
  /// API docs: https://dev.chartmogul.com/reference#list-data-sources
  Future<List<DataSource>> list() async {
    final Map<String, dynamic> response = await client.get(_endpoint);
    if (!response.containsKey('data_sources') ||
        !(response['data_sources'] is List)) {
      throw MalformedResponseException(
        'We received a 2XX response code and valid JSON '
        'but it contained an unexpected payload.',
        response.toString(),
      );
    }
    return response['data_sources']
        .map<DataSource>((dynamic map) => DataSource.fromJson(map))
        .toList();
  }
}
