import 'package:chartmogul/chartmogul.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

const List<int> successfulStatusCodes = <int>[200, 201, 202, 204];

const Map<int, Type> exceptionsForStatusCodes = <int, Type>{
  400: ClientException,
  401: AuthorizationException,
  402: RequestFailedException,
  403: AuthorizationException,
  404: NotFoundException,
  422: ClientException,
  429: RateLimitException,
  500: ServerException,
  502: ServerException,
  503: ServerException,
  504: ServerException,
};

void main() {
  test(
      'API instance correctly encodes account tokens and secret keys in headers',
      () async {
    final Map<String, String> expectedHeaders = <String, String>{
      'Authorization':
          "Basic 'dGVzdEFjY291bnRUb2tlbjp0ZXN0U2VjcmV0S2V5'", // testAccountToken:testSecretKey encoded as base64
    };

    final MockHttpClient mockClient = MockHttpClient();
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) => Future<http.Response>.value(
        http.Response('{"data": "pong!"}', 200),
      ),
    );

    final ChartMogul chartMogul = ChartMogul(
      accountToken: 'testAccountToken',
      secretKey: 'testSecretKey',
      client: mockClient,
    );

    await chartMogul.get('');
    verify(mockClient.get(
      any,
      headers: argThat(equals(expectedHeaders), named: 'headers'),
    ));
  });

  for (final int statusCode in exceptionsForStatusCodes.keys) {
    final Type exceptionType = exceptionsForStatusCodes[statusCode];

    test('API instance throws an $exceptionType on a $statusCode response',
        () async {
      final MockHttpClient mockClient = MockHttpClient();
      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future<http.Response>.value(
          http.Response(
            '{"data": "pong!"}',
            statusCode,
            request: http.Request('get', Uri()),
          ),
        ),
      );

      final ChartMogul chartMogul = ChartMogul(
        accountToken: '',
        secretKey: '',
        client: mockClient,
      );

      expect(
        () => chartMogul.get(''),
        throwsException,
      );

      try {
        await chartMogul.get('');
      } catch (e) {
        expect(e.toString(), contains(exceptionType.toString()));
      }
    });
  }

  for (final int statusCode in successfulStatusCodes) {
    test('API instance does not throw an exception on a $statusCode response',
        () async {
      final MockHttpClient mockClient = MockHttpClient();
      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future<http.Response>.value(
          http.Response(
            '{"data": "pong!"}',
            statusCode,
            request: http.Request('get', Uri()),
          ),
        ),
      );

      final ChartMogul chartMogul = ChartMogul(
        accountToken: '',
        secretKey: '',
        client: mockClient,
      );

      await chartMogul.get('');
      verify(mockClient.get(any, headers: anyNamed('headers')));
    });
  }
}
