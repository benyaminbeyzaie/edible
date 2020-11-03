import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../error/custom_exception.dart';

class ApiProvider {
  static const String URL =
      'https://gorcis.com/api/cache/edibles.php?ut=4d977504-6041-483a-b6ab-84f8fcef97c3';

  ApiProvider();

  Future<dynamic> get(String url, {Map body, bool utf8Support = false}) async {
    print('calling get');
    try {
      final headers = await getHeaders();

      print('one');
      final response = await http.get(url);

      print('two');
      final responseJson =
          _response(httpResponse: response, utf8Support: utf8Support);

      return responseJson;
    } on SocketException catch (e) {
      print(e.message);
      throw CustomException('Check the internet connection!');
    }
  }

  getHeaders() async {
    final headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json"
    };
    return headers;
  }

  dynamic _response({http.Response httpResponse, bool utf8Support = false}) {
    var response = httpResponse;

    print("API RESPONSE -->>>> code:${response.statusCode}");
    var responseJson = decodeResponse(utf8Support, response);
    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 201:
        return responseJson;
      case 400:
        throw CustomException(responseJson['error']);
      case 403:
        throw CustomException(responseJson['detail']);
      case 500:
        throw CustomException("Something went wrong");
      default:
        throw CustomException("Something went wrong!");
    }
  }

  decodeResponse(bool utf8Support, response) {
    if (utf8Support) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      return json.decode(response.body.toString());
    }
  }
}
