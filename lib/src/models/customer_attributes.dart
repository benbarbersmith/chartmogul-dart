import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'customer_attributes.g.dart';

/// Object to represent ChartMogul Customer Attributes.
///
/// Example of address JSON:
///
/// {
///   "tags": ["engage", "unit loss", "discountable"],
///   "stripe": {
///     "uid": 7,
///     "coupon": true
///   },
///   "clearbit": {
///     "id": "027b0d40-016c-40ea-8925-a076fa640992",
///     "name": "Acme",
///     "legalName": "Acme Inc.",
///     "domain": "acme.com",
///     "url": "http://acme.com",
///     "metrics": {
///       "raised": 1502450000,
///       "employees": 1000,
///       "googleRank": 7,
///       "alexaGlobalRank": 2319,
///       "marketCap": null
///     },
///     "category": {
///       "sector": "Information Technology",
///       "industryGroup": "Software and Services",
///       "industry": "Software",
///       "subIndustry": "Application Software"
///     }
///   },
///   "custom": {
///     "CAC": 213,
///     "utmCampaign": "social media 1",
///     "convertedAt": "2015-09-08 00:00:00",
///     "pro": false,
///     "salesRep": "Gabi"
///   }
/// }
@JsonSerializable()
class CustomerAttributes {
  const CustomerAttributes({
    this.clearbit,
    this.stripe,
    this.tags,
    this.custom,
  });
  factory CustomerAttributes.fromJson(Map<String, dynamic> json) =>
      _$CustomerAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerAttributesToJson(this);

  final Map<String, dynamic> clearbit;
  final Map<String, dynamic> stripe;
  final List<String> tags;
  final Map<String, dynamic> custom;
}

@JsonSerializable()
class CustomAttribute {
  CustomAttribute({
    @required this.key,
    @required this.value,
    String valueType,
    this.source,
  }) : type = valueType ?? _typeFromValue(value);
  Map<String, dynamic> toJson() => _$CustomAttributeToJson(this);

  static String _typeFromValue(dynamic value) {
    if (value is DateTime) {
      return 'Timestamp';
    } else if (value is bool) {
      return 'Boolean';
    } else if (value is int) {
      return 'Integer';
    } else if (value is double) {
      return 'Decimal';
    } else {
      return 'String';
    }
  }

  @JsonKey(nullable: false)
  final String key;

  @JsonKey(nullable: false)
  final dynamic value;

  /// One of String, Integer, Decimal, Timestamp or Boolean
  final String type;

  final String source;
}
