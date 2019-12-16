import 'package:chartmogul/src/models/plan.dart';
import 'package:test/test.dart';

const Map<String, dynamic> map = <String, dynamic>{
  'uuid': 'pl_eed05d54-75b4-431b-adb2-eb6b9e543206',
  'data_source_uuid': 'ds_fef05d54-47b4-431b-aed2-eb6b9e545430',
  'name': 'Bronze Plan',
  'interval_count': 1,
  'interval_unit': 'month',
  'external_id': 'plan_0001'
};

void main() {
  test('Plan can be created from expected JSON', () {
    final Plan plan = Plan.fromJson(map);

    expect(plan.uuid, equals(map['uuid']));
    expect(plan.externalId, equals(map['external_id']));
    expect(plan.name, equals(map['name']));
    expect(plan.intervalCount, equals(map['interval_count']));
    expect(plan.intervalUnit, equals(map['interval_unit']));
    expect(plan.dataSourceUuid, equals(map['data_source_uuid']));
  });

  test('Valid JSON can be created from plan', () {
    final Plan plan = Plan.fromJson(map);
    final Map<String, dynamic> json = plan.toJson();

    expect(json['uuid'], equals(map['uuid']));
    expect(json['external_id'], equals(map['external_id']));
    expect(json['name'], equals(map['name']));
    expect(json['data_source_uuid'], equals(map['data_source_uuid']));
    expect(json['interval_count'], equals(map['interval_count']));
    expect(json['interval_unit'], equals(map['interval_unit']));
  });
}
