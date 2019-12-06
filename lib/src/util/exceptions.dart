import 'package:http/http.dart' as http;

class AuthorizationException implements Exception {
  AuthorizationException(this.cause);
  String cause;

  @override
  String toString() => 'AuthorizationException: $cause';
}

class ClientException implements Exception {
  ClientException(this.cause, this.body);
  String cause;
  String body;

  @override
  String toString() => 'ClientException: $cause, $body';
}

class MalformedResponseException implements Exception {
  MalformedResponseException(this.description, this.body);
  String description;
  String body;

  @override
  String toString() => 'MalformedResponseException: $description, $body';
}

class NotFoundException implements Exception {
  NotFoundException(this.endpoint);
  String endpoint;

  @override
  String toString() => 'NotFoundException: $endpoint';
}

class RateLimitException implements Exception {
  RateLimitException(this.request);
  http.Request request;

  @override
  String toString() =>
      'RateLimitException: The rate limit is 40 requests/second. A request '
      'exceeded this limit: $request';
}

class RequestFailedException implements Exception {
  RequestFailedException(this.request);
  http.Request request;

  @override
  String toString() => 'RequestFailedException: $request';
}

class ServerException implements Exception {
  ServerException(this.request);
  http.Request request;

  @override
  String toString() => 'ServerException: $request';
}
