# Unofficial ChartMogul API Dart Client

`chartmogul-dart` provides convenient Dart bindings for [ChartMogul's API](https://dev.chartmogul.com).

----

## Table of Contents

* [Configuration](#configuration)
* [Usage](#usage)
* [Development](#development)
* [Contributing](#contributing)
* [License](#license)

----

## Configuration

To get started, you need to instantiate a ChartMogul client using your credentials. Find them on the [ChartMogul API Credentials page](https://app.chartmogul.com/#/admin/api).

```dart
final ChartMogul chartmogul = ChartMogul(accountToken: 'YOUR_TOKEN', secretKey: 'YOUR_KEY');
```

You can use the ping service to test everything is working:

```dart
await chartmogul.ping.authenticateCredentials();
print('If you can see this, everything worked!');
```

If there are no exceptions then you're good to go.

## Usage

### Import API

Available methods in Import API:

#### [Data Sources](https://dev.chartmogul.com/docs/data-sources)

```dart
chartMogul.dataSources.create('In-house billing');
chartMogul.dataSources.get('ds_5915ee5a-babd-406b-b8ce-d207133fb4cb');
chartMogul.dataSources.list();
chartMogul.dataSources.delete('ds_5915ee5a-babd-406b-b8ce-d207133fb4cb');
```

#### [Customers](https://dev.chartmogul.com/docs/customers)

```dart
chartMogul.customers.create(
  externalId: 'cus_0001',
  name: 'Adam Smith',
  dataSourceUuid: 'ds_fef05d54-47b4-431b-aed2-eb6b9e545430',
  email: 'adam@smith.com',
  address: const Address(city: 'New York', country: 'US'),
  leadCreatedAt: DateTime.parse('2015-10-14T00:00:00Z'),
  freeTrialStartedAt: DateTime.now(),
  customAttributes: <CustomAttribute>[
    CustomAttribute(key: 'channel', value: 'Facebook', source: 'Integration'),
    CustomAttribute(key: 'age', value: 18),
  ],
  tags: <String>['important', 'Prio1'],
);

chartMogul.customers.update(
  uuid: 'cus_5915ee5a-babd-406b-b8ce-d207133fb4cb',
  address: const Address(
    city: 'San Francisco',
    country: 'US',
    state: 'CA',
  ),
  leadCreatedAt: DateTime.parse('2015-01-01 00:00:00'),
  freeTrialStartedAt: DateTime.parse('2015-06-13 15:45:13'),
  customerAttributes: CustomerAttributes(
    tags: <String>['high-value'],
    custom: <String, dynamic>{
      'CAC': 25,
      'channel': <String, dynamic>{
        'value': 'Twitter',
        'source': 'integration2',
      },
    },
  ),
);

chartMogul.customers.list(page: 2, perPage: 20);
chartMogul.customers.get('cus_5915ee5a-babd-406b-b8ce-d207133fb4cb');
chartMogul.customers.delete('cus_5915ee5a-babd-406b-b8ce-d207133fb4cb');
```


#### [Plans](https://dev.chartmogul.com/docs/plans)

```dart
chartMogul.plans.create(
  externalId: 'plan_0001',
  name: 'Bronze Plan',
  dataSourceUuid: 'ds_fef05d54-47b4-431b-aed2-eb6b9e545430',
  intervalCount: 1,
  intervalUnit: 'month',
);

chartMogul.plans.update(
  uuid: 'pl_eed05d54-75b4-431b-adb2-eb6b9e543206',
  name: 'Bronze Monthly Plan',
  intervalCount: 1,
  intervalUnit: 'month',
);

chartMogul.plans.list(page: 2, perPage: 20);
chartMogul.plans.get('pl_eed05d54-75b4-431b-adb2-eb6b9e543206');
chartMogul.plans.delete('pl_eed05d54-75b4-431b-adb2-eb6b9e543206');
```

#### [Subscriptions](https://dev.chartmogul.com/docs/subscriptions)

```dart
chartMogul.subscriptions.list(
  customerUuid: 'cus_f466e33d-ff2b-4a11-8f85-417eb02157a7',
  perPage: 2,
  page: 3,
);

chartMogul.subscriptions.cancel(
  uuid: 'sub_e6bc5407-e258-4de0-bb43-61faaf062035',
  cancelledAt: DateTime.now(),
);

chartMogul.subscriptions.cancel(
  uuid: 'sub_e6bc5407-e258-4de0-bb43-61faaf062035',
  cancellationDates: <DateTime>[
    DateTime.now(),
    DateTime.fromMillisecondsSinceEpoch(1576513420)
  ],
);
```

## Development

To work on the library:

* Fork it
* Create your feature branch (`git checkout -b my-new-feature`)
* Install dependencies: `pub get`
* Fix bugs or add features, making sure the changes pass the linter (use `dartanalyzer`)
* Write tests for your new features, using `mockito` for HTTP mocking
* Run tests with `pub run test`
* If all tests are passed, push to the branch (`git push origin my-new-feature`)
* Create a new Pull Request

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/benbarbersmith/chartmogul-dart](https://github.com/benbarbersmith/chartmogul-dart).

## License

The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

### The MIT License (MIT)

Copyright (c) 2019 Benjamin Barbersmith

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
