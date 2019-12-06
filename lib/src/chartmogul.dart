import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'services/ping.dart';

class ChartMogul {
  /// Creates a new [ChartMogul] API client.
  ///
  /// [accountToken] is the Account Token provided on https://app.chartmogul.com/#/admin/api
  /// [secretKey] is the Secret Key provided on https://app.chartmogul.com/#/admin/api
  ChartMogul({
    @required String accountToken,
    @required String secretKey,
    http.Client client,
  })  : _authHeaders = _constructAuthHeaders(accountToken, secretKey),
        _client = client ?? http.Client();

  static const String apiBaseURL = 'https://api.chartmogul.com';
  static const String apiVersion = 'v1';

  final Map<String, String> _authHeaders;
  final http.Client _client = http.Client();

  PingService _ping;

  PingService get ping {
    _ping ??= PingService(this);
    return _ping;
  }

  void dispose() {
    _client.close();
  }

  Future<T> delete<T>(String endpoint) async =>
      _sendRequest(verb: 'DELETE', endpoint: endpoint);

  Future<T> get<T>(String endpoint) async =>
      _sendRequest(verb: 'GET', endpoint: endpoint);

  Future<T> patch<T>(String endpoint, Map<String, dynamic> body) async =>
      _sendRequest(verb: 'PATCH', endpoint: endpoint, body: body);

  Future<T> post<T>(String endpoint, Map<String, dynamic> body) =>
      _sendRequest(verb: 'POST', endpoint: endpoint, body: body);

  Future<T> put<T>(String endpoint, Map<String, dynamic> body) =>
      _sendRequest(verb: 'PUT', endpoint: endpoint, body: body);

  /// Handles expected ChartMogul API response codes
  ///
  /// When processing responses from the ChartMogul API, we respect the
  /// response codes from the documentation:
  /// https://dev.chartmogul.com/docs/response-codes
  void _handleResponseCode(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
      case 204:
        // Nothing to do in these cases, everything worked as expected.
        return;
      case 400:
        //  Bad Request (Often missing a required parameter)
        throw ClientException('Bad Request', response.body);
      case 401:
        // Unauthorized (Authentication failed)
        throw AuthorizationException('Invalid credentials');
      case 402:
        // Request Failed (Parameters were valid but request failed)
        throw RequestFailedException(response.request);
      case 403:
        // Forbidden (Trial account has expired)
        throw AuthorizationException('Trial account has expired');
      case 404:
        // Not Found (The requested item doesn't exist)
        throw NotFoundException(response.request.url.toString());
      case 422:
        // Unprocessable Entity (Your request has semantic errors)
        throw ClientException('Unprocessable Entity', response.body);
      case 429:
        // Too many requests (You have exceeded our rate limits)
        throw RateLimitException(response.request);
      case 500:
      case 502:
      case 503:
      case 504:
        // Server Errors (Something went wrong on ChartMogul's end)
        throw ServerException(response.request);
    }
  }

  Future<T> _sendRequest<T>({
    @required String verb,
    @required String endpoint,
    Map<String, dynamic> body,
  }) async {
    final String url = '$apiBaseURL/$apiVersion/$endpoint';

    http.Response response;
    switch (verb) {
      case 'DELETE':
        response = await _client.delete(url, headers: _authHeaders);
        break;
      case 'GET':
        response = await _client.get(url, headers: _authHeaders);
        break;
      case 'PATCH':
        response = await _client.patch(url, headers: _authHeaders, body: body);
        break;
      case 'POST':
        response = await _client.post(url, headers: _authHeaders, body: body);
        break;
      case 'PUT':
        response = await _client.put(url, headers: _authHeaders, body: body);
        break;
      default:
        throw ClientException(
            'Unexpected request: $verb $endpoint', body?.toString() ?? '');
    }

    _handleResponseCode(response);
    try {
      return json.decode(response.body);
    } catch (e) {
      throw ClientException(
          'Received malformed response from API', response.body);
    }
  }

  static Map<String, String> _constructAuthHeaders(
    String accountToken,
    String secretKey,
  ) {
    return <String, String>{
      'Authorization':
          "Basic '${base64.encode("$accountToken:$secretKey".codeUnits)}'}",
    };
  }
}
