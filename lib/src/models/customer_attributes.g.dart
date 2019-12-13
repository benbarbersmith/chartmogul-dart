// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerAttributes _$CustomerAttributesFromJson(Map<String, dynamic> json) {
  return CustomerAttributes(
    clearbit: json['clearbit'] as Map<String, dynamic>,
    stripe: json['stripe'] as Map<String, dynamic>,
    tags: (json['tags'] as List)?.map((e) => e as String)?.toList(),
    custom: json['custom'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$CustomerAttributesToJson(CustomerAttributes instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('clearbit', instance.clearbit);
  writeNotNull('stripe', instance.stripe);
  writeNotNull('tags', instance.tags);
  writeNotNull('custom', instance.custom);
  return val;
}

Map<String, dynamic> _$CustomAttributeToJson(CustomAttribute instance) {
  final val = <String, dynamic>{
    'key': instance.key,
    'value': instance.value,
    'type': instance.type,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('source', instance.source);
  return val;
}
