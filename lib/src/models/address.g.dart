// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    country: json['country'] as String,
    state: json['state'] as String,
    city: json['city'] as String,
    zip: json['address_zip'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('country', instance.country);
  writeNotNull('state', instance.state);
  writeNotNull('city', instance.city);
  writeNotNull('address_zip', instance.zip);
  return val;
}
