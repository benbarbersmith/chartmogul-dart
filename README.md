# Unofficial ChartMogul API Dart Client

`chartmogul-dart` provides convenient Dart bindings for [ChartMogul's API](https://dev.chartmogul.com).

## Configuration

To get started, you need to instantiate a ChartMogul client using your credentials. Find them on the [ChartMogul API Credentials page](https://app.chartmogul.com/#/admin/api).

```dart
final ChartMogul chartmogul = ChartMogul(accountToken: 'YOUR_TOKEN', secretKey: 'YOUR_KEY');
```

You can the ping service to test everything is working:

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

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/benbarbersmith/chartmogul-dart](https://github.com/benbarbersmith/chartmogul-dart).

## License

The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

### The MIT License (MIT)

Copyright (c) 2019 Benjamin Barbersmith

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
