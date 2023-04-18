// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:RecipeX/api/settings.dart';
import 'package:http/http.dart' as http;

import '../keys/api_keys.dart';
import 'errors.dart';

class BaseAPI {
  Uri getAPI(String path) {
    return Uri.parse(
        "${ApiSetting.REQUEST_SCHEMA}://${ApiSetting.API_HOST}/${ApiSetting.API_PATH}/$path");
  }

  Future<Map<String, dynamic>> post(Uri api, [Object? body]) async {
    try {
      var requestHeaders = headers();
      http.Response response =
          await http.post(api, headers: requestHeaders, body: jsonEncode(body));
      final jsonData = jsonDecode(response.body);

      if (response.statusCode == HttpStatus.unauthorized) {
        throw UnauthorizedException();
      } else if (response.statusCode == HttpStatus.internalServerError) {
        throw ServerErrorException();
      } else {
        return jsonData;
      }
    } on SocketException {
      throw NoInternetException();
    }
  }

  Future<Map<String, dynamic>> put(Uri api, [Object? body]) async {
    try {
      var requestHeaders = headers();
      http.Response response =
          await http.put(api, headers: requestHeaders, body: jsonEncode(body));
      final jsonData = jsonDecode(response.body);

      if (response.statusCode == HttpStatus.unauthorized) {
        throw UnauthorizedException();
      } else if (response.statusCode == HttpStatus.internalServerError) {
        throw ServerErrorException();
      } else {
        return jsonData;
      }
    } on SocketException {
      throw NoInternetException();
    }
  }

  Future<Map<String, dynamic>> get(Uri api,
      {Map<String, dynamic>? queryParams}) async {
    try {
      var requestHeaders = headers();
      if (queryParams != null && queryParams.isNotEmpty) {
        api = api.replace(queryParameters: queryParams);
      }
      http.Response response = await http.get(api, headers: requestHeaders);
      final jsonData = jsonDecode(response.body);
 
      if (response.statusCode == HttpStatus.unauthorized) {
        throw UnauthorizedException();
      } else if (response.statusCode == HttpStatus.internalServerError) {
        throw ServerErrorException();
      } else if (jsonData["message"] != null) {
        print("Helloww");
        throw ExceededApiRequest();
      } else {
        return jsonData;
      }
    } on SocketException {
      throw NoInternetException();
    }
  }

  Future<Map<String, dynamic>> delete(Uri api,
      {Map<String, String>? queryParams}) async {
    try {
      var requestHeaders = headers();
      if (queryParams != null && queryParams.isNotEmpty) {
        api = api.replace(queryParameters: queryParams);
      }
      http.Response response = await http.delete(api, headers: requestHeaders);
      final jsonData = jsonDecode(response.body);

      if (response.statusCode == HttpStatus.unauthorized) {
        throw UnauthorizedException();
      } else if (response.statusCode == HttpStatus.internalServerError) {
        throw ServerErrorException();
      } else {
        return jsonData;
      }
    } on SocketException {
      throw NoInternetException();
    }
  }

  Map<String, String> headers({
    String langResult = "en",
  }) {
    var headers = {
      "Content-Type": "application/json",
      'X-RapidAPI-Key': APIKeys.apiKey,
      'X-RapidAPI-Host': APIKeys.apiHost
    };

    return headers;
  }
}
