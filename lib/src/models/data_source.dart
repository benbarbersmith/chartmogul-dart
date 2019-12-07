/// Object to represent a ChartMogul Data Source.
///
/// Example data source JSON:
///
/// {
///     "uuid": "ds_fef05d54-47b4-431b-aed2-eb6b9e545430",
///     "name": "In-house billing",
///     "system": "Import API",
///     "created_at": "2016-01-10T15:34:05Z",
///     "status": "idle"
/// }
class DataSource {
  DataSource({this.name, this.uuid, this.system, this.createdAt, this.status});

  DataSource.fromMap(Map<String, dynamic> map)
      : assert(map.containsKey('uuid')),
        assert(map.containsKey('name')),
        assert(map.containsKey('system')),
        assert(map.containsKey('created_at')),
        assert(map.containsKey('status')),
        uuid = map['uuid'],
        name = map['name'],
        system = map['system'],
        createdAt = DateTime.parse(map['created_at']),
        status = DataSourceStatus.values.firstWhere(
            (DataSourceStatus s) => s.toString().endsWith(map['status']));

  final String uuid;
  final String name;
  final String system;
  final DateTime createdAt;
  final DataSourceStatus status;

  @override
  String toString() => '$name ($uuid)';
}

/// Possible states for the status of a ChartMogul Data Source.
///
/// Listed under `status` on the API documentation:
/// https://dev.chartmogul.com/reference#create-data-source
enum DataSourceStatus {
  never_imported,
  importing,
  import_complete,
  working,
  idle,
}
