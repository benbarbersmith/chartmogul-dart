import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription.g.dart';

/// Object to represent a ChartMogul Subscription.
///
/// Example Subscription JSON:
/// {
///   "uuid": "sub_e6bc5407-e258-4de0-bb43-61faaf062035",
///   "external_id": "sub_0001",
///   "subscription_set_external_id": "set_0001",
///   "plan_uuid": "pl_eed05d54-75b4-431b-adb2-eb6b9e543206",
///   "data_source_uuid": "ds_fef05d54-47b4-431b-aed2-eb6b9e545430",
///   "cancellation_dates":[]
/// }
@JsonSerializable()
class Subscription {
  const Subscription({
    @required this.uuid,
    @required this.externalId,
    @required this.dataSourceUuid,
    @required this.planUuid,
    this.subscriptionSetExternalId,
    this.cancellationDates,
  });
  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);

  /// The UUID of the subscription object generated by ChartMogul.
  @JsonKey(name: 'uuid')
  final String uuid;

  /// The unique external identifier for this subscription, as specified by you.
  @JsonKey(name: 'external_id')
  final String externalId;

  /// An optional unique external identifier for the subscription set to which this subscription belongs, as specified by you.
  @JsonKey(name: 'subscription_set_external_id')
  final String subscriptionSetExternalId;

  /// The UUID of the plan object generated by ChartMogul.
  @JsonKey(name: 'plan_uuid')
  final String planUuid;

  /// The UUID of the data source that this subscription plan belongs to.
  @JsonKey(name: 'data_source_uuid')
  final String dataSourceUuid;

  /// An array of cancelled_at attributes specified by you. This is an array because a subscription may be re-activated and cancelled several times.
  @JsonKey(name: 'cancellation_dates')
  final List<DateTime> cancellationDates;
}

@JsonSerializable()
class SubscriptionResults {
  const SubscriptionResults({
    this.entries,
    this.currentPage,
    this.totalPages,
  });

  factory SubscriptionResults.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionResultsFromJson(json);

  /// An array of objects from the API.
  @JsonKey(name: 'subscriptions')
  final List<Subscription> entries;

  /// The page number of this response.
  @JsonKey(name: 'current_page')
  final int currentPage;

  /// The total number of pages with results for this request.
  @JsonKey(name: 'total_pages')
  final int totalPages;
}
