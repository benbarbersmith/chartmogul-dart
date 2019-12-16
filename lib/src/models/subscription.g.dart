// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) {
  return Subscription(
    uuid: json['uuid'] as String,
    externalId: json['external_id'] as String,
    dataSourceUuid: json['data_source_uuid'] as String,
    planUuid: json['plan_uuid'] as String,
    subscriptionSetExternalId: json['subscription_set_external_id'] as String,
    cancellationDates: (json['cancellation_dates'] as List)
        ?.map((e) => e == null ? null : DateTime.parse(e as String))
        ?.toList(),
  );
}

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uuid', instance.uuid);
  writeNotNull('external_id', instance.externalId);
  writeNotNull(
      'subscription_set_external_id', instance.subscriptionSetExternalId);
  writeNotNull('plan_uuid', instance.planUuid);
  writeNotNull('data_source_uuid', instance.dataSourceUuid);
  writeNotNull('cancellation_dates',
      instance.cancellationDates?.map((e) => e?.toIso8601String())?.toList());
  return val;
}

SubscriptionResults _$SubscriptionResultsFromJson(Map<String, dynamic> json) {
  return SubscriptionResults(
    entries: (json['subscriptions'] as List)
        ?.map((e) =>
            e == null ? null : Subscription.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    currentPage: json['current_page'] as int,
    totalPages: json['total_pages'] as int,
  );
}

Map<String, dynamic> _$SubscriptionResultsToJson(SubscriptionResults instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('subscriptions', instance.entries);
  writeNotNull('current_page', instance.currentPage);
  writeNotNull('total_pages', instance.totalPages);
  return val;
}
