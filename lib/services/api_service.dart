import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:kcal_control_frontend/models/user.dart';

class ApiService {
  static final ApiService _singleton = ApiService._();

  ApiService._();

  static ApiService get instance {
    return _singleton;
  }

  final String _baseUrl = 'https://localhost:8081';
  late String? _accessToken;
  late String? _refreshToken;
  late String? id;
  late String? _role;

  Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('assets/certificates/localhost.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }

  Future<bool> login(String username, String password) async {
    Uri uri = Uri.parse('$_baseUrl/login');
    final request = await HttpClient(context: await globalContext)
        .postUrl(uri)
        .then((HttpClientRequest request) {
      request.headers.contentType =
          ContentType('application', 'json', charset: 'utf-8');
      request.write(jsonEncode({'username': username, 'password': password}));
      return request.close();
    });
    // final response = await http.post(uri,
    //     headers: {'Content-Type': 'application/json; charset=UTF-8'},
    //     body: json.encode({'username': username, 'password': password}));
    // if (response.statusCode == 200) {
    //   _accessToken = (jsonDecode(response.body)[
    //       'accessToken']); // Should extract token from response body.
    //   _refreshToken = (jsonDecode(response.body)['refreshToken']);
    //   id = jsonDecode(response.body)['id'];
    //   _role = jsonDecode(response.body)['roleName'];
    //   return true;
    // } else {
    //   throw Exception('Failed to login: ${response.body}');
    // }

    final response = await request.transform(utf8.decoder).join();

    final responseData = jsonDecode(response);
    if (responseData['statusCode'] == 200) {
      _accessToken = responseData['accessToken'];
      _refreshToken = responseData['refreshToken'];
      id = responseData['id'];
      _role = responseData['roleName'];
      return true;
    } else {
      throw Exception('Failed to login: $response');
    }
  }

  Future<bool> signup(User newUser) async {
    Uri uri = Uri.parse('$_baseUrl/signup');
    final response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(newUser));
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      throw Exception('Failed to add user');
    }
  }

  Future<bool> logout() async {
    Uri uri = Uri.parse('$_baseUrl/logout');
    final response = await http.post(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $_accessToken'
    });
    if (response.statusCode == 200) {
      _accessToken = null;
      id = null;
      _role = null;
      return true;
    } else {
      throw Exception('Logout failed');
    }
  }

  Future<Map<String, dynamic>> getAuth(String path) async {
    Uri uri = Uri.parse('$_baseUrl$path');
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $_accessToken'
    });
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'A ${response.statusCode} error occurred: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getNoAuth(String path) async {
    Uri uri = Uri.parse('$_baseUrl$path');
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'A ${response.statusCode} error occurred: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> post(
      String path, Map<String, dynamic> body) async {
    Uri uri = Uri.parse('$_baseUrl$path');
    final response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_accessToken'
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'A ${response.statusCode} error occurred: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> put(
      String path, Map<String, dynamic> body) async {
    Uri uri = Uri.parse('$_baseUrl$path');
    final response = await http.put(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_accessToken'
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'A ${response.statusCode} error occurred: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> delete(
      String path, Map<String, dynamic> body) async {
    Uri uri = Uri.parse('$_baseUrl$path');
    final response = await http.delete(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_accessToken'
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'A ${response.statusCode} error occurred: ${response.body}');
    }
  }
}
