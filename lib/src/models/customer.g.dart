// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['external_id', 'data_source_uuid', 'name']);
  return Customer(
    dataSourceUuid: json['data_source_uuid'] as String,
    externalId: json['external_id'] as String,
    name: json['name'] as String,
    uuid: json['uuid'] as String,
    id: json['id'] as int,
    email: json['email'] as String,
    company: json['company'] as String,
    status: json['status'] as String,
    externalIds: (json['external_ids'] as List)
        ?.map((dynamic e) => e as String)
        ?.toList(),
    dataSourceUuids: (json['data_source_uuids'] as List)
        ?.map((dynamic e) => e as String)
        ?.toList(),
    leadCreatedAt: json['lead_created_at'] == null
        ? null
        : DateTime.parse(json['lead_created_at'] as String),
    freeTrialStartedAt: json['free_trial_started_at'] == null
        ? null
        : DateTime.parse(json['free_trial_started_at'] as String),
    customerSince: json['customer-since'] == null
        ? null
        : DateTime.parse(json['customer-since'] as String),
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    attributes: json['attributes'] == null
        ? null
        : CustomerAttributes.fromJson(
            json['attributes'] as Map<String, dynamic>),
    mrr: json['mrr'] as int,
    arr: json['arr'] as int,
    billingSystemUrl: json['billing-system-url'] as String,
    chartmogulUrl: json['chartmogul-url'] as String,
    billingSystemType: json['billing-system-type'] as String,
    currency: json['currency'] as String,
    currencySign: json['currency-sign'] as String,
  );
}

Map<String, dynamic> _$CustomerToJson(Customer instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('uuid', instance.uuid);
  writeNotNull('external_id', instance.externalId);
  writeNotNull('external_ids', instance.externalIds);
  writeNotNull('data_source_uuid', instance.dataSourceUuid);
  writeNotNull('data_source_uuids', instance.dataSourceUuids);
  writeNotNull('name', instance.name);
  writeNotNull('email', instance.email);
  writeNotNull('company', instance.company);
  writeNotNull('status', instance.status);
  writeNotNull('lead_created_at', instance.leadCreatedAt?.toIso8601String());
  writeNotNull(
      'free_trial_started_at', instance.freeTrialStartedAt?.toIso8601String());
  writeNotNull('customer-since', instance.customerSince?.toIso8601String());
  writeNotNull('attributes', instance.attributes.toJson());
  writeNotNull('address', instance.address.toJson());
  writeNotNull('mrr', instance.mrr);
  writeNotNull('arr', instance.arr);
  writeNotNull('billing-system-url', instance.billingSystemUrl);
  writeNotNull('chartmogul-url', instance.chartmogulUrl);
  writeNotNull('billing-system-type', instance.billingSystemType);
  writeNotNull('currency', instance.currency);
  writeNotNull('currency-sign', instance.currencySign);
  return val;
}

CustomerResults _$CustomerResultsFromJson(Map<String, dynamic> json) {
  return CustomerResults(
    entries: (json['entries'] as List)
        ?.map((dynamic e) =>
            e == null ? null : Customer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    perPage: json['per_page'] as int,
    page: json['page'] as int,
    currentPage: json['current_page'] as int,
    totalPages: json['total_pages'] as int,
    hasMore: json['has_more'] as bool,
  );
}

Map<String, dynamic> _$CustomerResultsToJson(CustomerResults instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('entries', instance.entries);
  writeNotNull('per_page', instance.perPage);
  writeNotNull('page', instance.page);
  writeNotNull('current_page', instance.currentPage);
  writeNotNull('total_pages', instance.totalPages);
  writeNotNull('has_more', instance.hasMore);
  return val;
}
