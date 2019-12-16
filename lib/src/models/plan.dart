import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plan.g.dart';

/// Object to represent a ChartMogul Plan.
///
/// Example Plan JSON:
/// {
///    "uuid": "pl_eed05d54-75b4-431b-adb2-eb6b9e543206",
///    "data_source_uuid": "ds_fef05d54-47b4-431b-aed2-eb6b9e545430",
///    "name": "Bronze Plan",
///    "interval_count": 1,
///    "interval_unit": "month",
///    "external_id": "plan_0001"
/// }
@JsonSerializable()
class Plan {
  const Plan({
    @required this.dataSourceUuid,
    @required this.name,
    this.uuid,
    this.externalId,
    this.intervalUnit,
    this.intervalCount,
  });
  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
  Map<String, dynamic> toJson() => _$PlanToJson(this);

  /// The ChartMogul UUID of the subscription plan.
  final String uuid;

  /// The ChartMogul UUID of the data source for this subscription plan.
  @JsonKey(name: 'data_source_uuid')
  final String dataSourceUuid;

  /// Display name of the plan. Accepts alphanumeric characters.
  final String name;

  /// The frequency of billing interval. Accepts integers greater than 0. eg. 6 for a half-yearly plan.
  @JsonKey(name: 'interval_count')
  final int intervalCount;

  /// The unit of billing interval. One of day, month, or year. eg. month for the above half-yearly plan.
  @JsonKey(name: 'interval_unit')
  final String intervalUnit;

  /// A unique identifier specified by you for the plan. Typically an identifier from your internal system. Accepts alphanumeric characters.
  @JsonKey(name: 'external_id')
  final String externalId;
}

@JsonSerializable()
class PlanResults {
  const PlanResults({
    this.entries,
    this.currentPage,
    this.totalPages,
  });

  factory PlanResults.fromJson(Map<String, dynamic> json) =>
      _$PlanResultsFromJson(json);

  /// An array of objects from the API.
  @JsonKey(name: 'plans')
  final List<Plan> entries;

  /// The page number of this response.
  @JsonKey(name: 'current_page')
  final int currentPage;

  /// The total number of pages with results for this request.
  @JsonKey(name: 'total_pages')
  final int totalPages;
}
