// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plan _$PlanFromJson(Map<String, dynamic> json) {
  return Plan(
    dataSourceUuid: json['data_source_uuid'] as String,
    name: json['name'] as String,
    uuid: json['uuid'] as String,
    externalId: json['external_id'] as String,
    intervalUnit: json['interval_unit'] as String,
    intervalCount: json['interval_count'] as int,
  );
}

Map<String, dynamic> _$PlanToJson(Plan instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uuid', instance.uuid);
  writeNotNull('data_source_uuid', instance.dataSourceUuid);
  writeNotNull('name', instance.name);
  writeNotNull('interval_count', instance.intervalCount);
  writeNotNull('interval_unit', instance.intervalUnit);
  writeNotNull('external_id', instance.externalId);
  return val;
}

PlanResults _$PlanResultsFromJson(Map<String, dynamic> json) {
  return PlanResults(
    entries: (json['plans'] as List)
        ?.map(
            (e) => e == null ? null : Plan.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    currentPage: json['current_page'] as int,
    totalPages: json['total_pages'] as int,
  );
}

Map<String, dynamic> _$PlanResultsToJson(PlanResults instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('plans', instance.entries);
  writeNotNull('current_page', instance.currentPage);
  writeNotNull('total_pages', instance.totalPages);
  return val;
}
