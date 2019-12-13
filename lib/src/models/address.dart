import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

/// Object to represent a ChartMogul Customer Address.
///
/// Example of address JSON:
///
/// "address": {
///   "country": "United States",
///   "state": null,
///   "city": "New York",
///   "address_zip": null
/// }
@JsonSerializable()
class Address {
  const Address({
    this.country,
    this.state,
    this.city,
    this.zip,
  });
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);

  final String country;
  final String state;
  final String city;
  @JsonKey(name: 'address_zip')
  final String zip;
}
