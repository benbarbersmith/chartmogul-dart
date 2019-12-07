import '../chartmogul.dart';
import '../util/exceptions.dart';
import '../util/service.dart';

/// Implements the ping endpoint of the ChartMogul API.
///
/// API docs: https://dev.chartmogul.com/docs/authentication
class PingService implements Service {
  PingService(this.client);

  @override
  ChartMogul client;

  Future<void> authenticateCredentials() async {
    final Map<String, dynamic> response = await client.get('ping');

    // If we get a OK response from the server, the body always should be:
    // {'data': 'pong!'}
    if (!response.containsKey('data') || response['data'] != 'pong!') {
      // Throws an exception if credentials are invalid
      throw MalformedResponseException(
        'We received a 2XX response code and valid JSON from the ping test '
        'but it contained an unexpected payload.',
        response.toString(),
      );
    }
  }
}
