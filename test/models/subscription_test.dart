import 'package:chartmogul/src/models/subscription.dart';
import 'package:test/test.dart';

const Map<String, dynamic> map = <String, dynamic>{
  'uuid': 'sub_e6bc5407-e258-4de0-bb43-61faaf062035',
  'external_id': 'sub_0001',
  'subscription_set_external_id': 'set_0001',
  'plan_uuid': 'pl_eed05d54-75b4-431b-adb2-eb6b9e543206',
  'data_source_uuid': 'ds_fef05d54-47b4-431b-aed2-eb6b9e545430',
  'cancellation_dates': <String>[],
};

void main() {
  test('Subscription can be created from expected JSON', () {
    final Subscription subscription = Subscription.fromJson(map);

    expect(subscription.uuid, equals(map['uuid']));
    expect(subscription.externalId, equals(map['external_id']));
    expect(subscription.planUuid, equals(map['plan_uuid']));
    expect(subscription.cancellationDates, isEmpty);
    expect(subscription.subscriptionSetExternalId,
        equals(map['subscription_set_external_id']));
    expect(subscription.dataSourceUuid, equals(map['data_source_uuid']));
  });

  test('Valid JSON can be created from Subscription', () {
    final Subscription subscription = Subscription.fromJson(map);
    final Map<String, dynamic> json = subscription.toJson();

    expect(json['uuid'], equals(map['uuid']));
    expect(json['external_id'], equals(map['external_id']));
    expect(json['plan_uuid'], equals(map['plan_uuid']));
    expect(json['subscription_set_external_id'],
        equals(map['subscription_set_external_id']));
    expect(json['data_source_uuid'], equals(map['data_source_uuid']));
    expect(json['cancellation_dates'], equals(map['cancellation_dates']));
  });
}
