import 'package:chartmogul/chartmogul.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

const String pingEndpoint = 'https://api.chartmogul.com/v1/ping';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  test('authenticateCredentials method sends a get request to $pingEndpoint',
      () async {
    final MockHttpClient mockClient = MockHttpClient();
    when(mockClient.get(pingEndpoint, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future<http.Response>.value(
            http.Response('{"data": "pong!"}', 200)));

    final ChartMogul chartMogul = ChartMogul(
      accountToken: '',
      secretKey: '',
      client: mockClient,
    );

    await chartMogul.ping.authenticateCredentials();
    verify(mockClient.get(pingEndpoint, headers: anyNamed('headers')));
  });

  test(
      'authenticateCredentials method throws a MalformedResponseException on a 200 response with an unexpected body',
      () async {
    final MockHttpClient mockClient = MockHttpClient();
    when(mockClient.get(pingEndpoint, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future<http.Response>.value(
            http.Response('{"data": "unexpected"}', 200)));

    final ChartMogul chartMogul = ChartMogul(
      accountToken: '',
      secretKey: '',
      client: mockClient,
    );

    expect(
      () async => await chartMogul.ping.authenticateCredentials(),
      throwsA(const TypeMatcher<MalformedResponseException>()),
    );
  });
}
