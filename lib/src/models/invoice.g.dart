// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
  return Invoice(
    externalId: json['external_id'] as String,
    date: DateTime.parse(json['date'] as String),
    currency: json['currency'] as String,
    lineItems: (json['line_items'] as List)
        .map((e) => LineItem.fromJson(e as Map<String, dynamic>))
        .toList(),
    customerUuid: json['customer_uuid'] as String,
    uuid: json['uuid'] as String,
    dueDate: json['due_date'] == null
        ? null
        : DateTime.parse(json['due_date'] as String),
    transactions: (json['transactions'] as List)
        ?.map((e) =>
            e == null ? null : Transaction.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    dataSourceUuid: json['data_source_uuid'] as String,
  );
}

Map<String, dynamic> _$InvoiceToJson(Invoice instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uuid', instance.uuid);
  writeNotNull('customer_uuid', instance.customerUuid);
  val['external_id'] = instance.externalId;
  val['date'] = instance.date.toIso8601String();
  val['currency'] = instance.currency;
  val['line_items'] = instance.lineItems.map((LineItem l) => l.toJson());
  writeNotNull(
      'transactions', instance.transactions.map((Transaction t) => t.toJson()));
  writeNotNull('due_date', instance.dueDate?.toIso8601String());
  writeNotNull('data_source_uuid', instance.dataSourceUuid);
  return val;
}

LineItem _$LineItemFromJson(Map<String, dynamic> json) {
  return LineItem(
    type: _$enumDecode(_$LineItemTypeEnumMap, json['type']),
    amountInCents: json['amount_in_cents'] as int,
    uuid: json['uuid'] as String,
    subscriptionExternalId: json['subscription_external_id'] as String,
    subscriptionSetExternalId: json['subscription_set_external_id'] as String,
    planUuid: json['plan_uuid'] as String,
    servicePeriodStart: json['service_period_start'] == null
        ? null
        : DateTime.parse(json['service_period_start'] as String),
    servicePeriodEnd: json['service_period_end'] == null
        ? null
        : DateTime.parse(json['service_period_end'] as String),
    cancelledAt: json['cancelled_at'] == null
        ? null
        : DateTime.parse(json['cancelled_at'] as String),
    prorated: json['prorated'] as bool,
    description: json['description'] as String,
    quantity: json['quantity'] as int,
    discountAmountInCents: json['discount_amount_in_cents'] as int,
    discountCode: json['discount_code'] as String,
    taxAmountInCents: json['tax_amount_in_cents'] as int,
    transactionFeesInCents: json['transaction_fees_in_cents'] as int,
    externalId: json['external_id'] as String,
    accountCode: json['account_code'] as String,
  );
}

Map<String, dynamic> _$LineItemToJson(LineItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uuid', instance.uuid);
  val['type'] = _$LineItemTypeEnumMap[instance.type];
  writeNotNull('subscription_external_id', instance.subscriptionExternalId);
  writeNotNull(
      'subscription_set_external_id', instance.subscriptionSetExternalId);
  writeNotNull('plan_uuid', instance.planUuid);
  writeNotNull(
      'service_period_start', instance.servicePeriodStart?.toIso8601String());
  writeNotNull(
      'service_period_end', instance.servicePeriodEnd?.toIso8601String());
  writeNotNull('amount_in_cents', instance.amountInCents);
  writeNotNull('cancelled_at', instance.cancelledAt?.toIso8601String());
  writeNotNull('prorated', instance.prorated);
  writeNotNull('description', instance.description);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('discount_amount_in_cents', instance.discountAmountInCents);
  writeNotNull('discount_code', instance.discountCode);
  writeNotNull('tax_amount_in_cents', instance.taxAmountInCents);
  writeNotNull('transaction_fees_in_cents', instance.transactionFeesInCents);
  writeNotNull('external_id', instance.externalId);
  writeNotNull('account_code', instance.accountCode);
  return val;
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

const _$LineItemTypeEnumMap = {
  LineItemType.subscription: 'subscription',
  LineItemType.one_time: 'one_time',
};

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    date: DateTime.parse(json['date'] as String),
    type: _$enumDecode(_$TransactionTypeEnumMap, json['type']),
    result: _$enumDecode(_$TransactionResultEnumMap, json['result']),
    uuid: json['uuid'] as String,
    externalId: json['external_id'] as String,
  );
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uuid', instance.uuid);
  val['date'] = instance.date.toIso8601String();
  val['type'] = _$TransactionTypeEnumMap[instance.type];
  val['result'] = _$TransactionResultEnumMap[instance.result];
  writeNotNull('external_id', instance.externalId);
  return val;
}

const _$TransactionTypeEnumMap = {
  TransactionType.payment: 'payment',
  TransactionType.refund: 'refund',
};

const _$TransactionResultEnumMap = {
  TransactionResult.successful: 'successful',
  TransactionResult.failed: 'failed',
};

InvoiceResults _$InvoiceResultsFromJson(Map<String, dynamic> json) {
  return InvoiceResults(
    entries: (json['invoices'] as List)
        ?.map((e) =>
            e == null ? null : Invoice.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    currentPage: json['current_page'] as int,
    totalPages: json['total_pages'] as int,
    customerUuid: json['customer_uuid'] as String,
  );
}

Map<String, dynamic> _$InvoiceResultsToJson(InvoiceResults instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('invoices', instance.entries);
  writeNotNull('current_page', instance.currentPage);
  writeNotNull('total_pages', instance.totalPages);
  writeNotNull('customer_uuid', instance.customerUuid);
  return val;
}
