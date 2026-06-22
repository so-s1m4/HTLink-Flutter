import 'dart:convert';

import 'package:htlink/core/network/api_exception.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient({required this.baseUrl, http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client _httpClient;

  Future<Map<String, dynamic>> getObject(String path, {String? token}) async {
    final response = await _httpClient.get(
      _uri(path),
      headers: _headers(token: token),
    );

    return _decodeObjectResponse(response);
  }

  Future<List<Map<String, dynamic>>> getList(
    String path, {
    String? token,
  }) async {
    final response = await _httpClient.get(
      _uri(path),
      headers: _headers(token: token),
    );

    return _decodeListResponse(response);
  }

  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  Map<String, String> _headers({String? token}) => {
    'Accept': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };

  Map<String, dynamic> _decodeObjectResponse(http.Response response) {
    final body = _decodeBody(response.body);

    if (_isSuccessful(response.statusCode)) {
      if (body is Map<String, dynamic>) {
        return body;
      }

      throw const FormatException('Expected a JSON object');
    }

    throw _exceptionFromBody(body, response.statusCode);
  }

  List<Map<String, dynamic>> _decodeListResponse(http.Response response) {
    final body = _decodeBody(response.body);

    if (_isSuccessful(response.statusCode)) {
      if (body is List) {
        return body.cast<Map<String, dynamic>>();
      }

      throw const FormatException('Expected a JSON list');
    }

    throw _exceptionFromBody(body, response.statusCode);
  }

  Object? _decodeBody(String body) {
    if (body.isEmpty) {
      return null;
    }

    return jsonDecode(body);
  }

  bool _isSuccessful(int statusCode) => statusCode >= 200 && statusCode < 300;

  ApiException _exceptionFromBody(Object? body, int statusCode) {
    final message = body is Map<String, dynamic>
        ? body['message']?.toString()
        : null;

    return ApiException(message ?? 'Request failed', statusCode: statusCode);
  }
}
