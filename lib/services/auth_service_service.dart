import 'dart:async';
import 'dart:convert';
// import 'dart:ffi';
import 'dart:io';
import '/services/web_client_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class AuthService {
  //
  static String url = WebClient.url;
  http.Client client = WebClient().client;

  List<String> errorMessages = [
    "{detail: O token é inválido ou expirado, code: token_not_valid}",
    "{token: [Este campo é obrigatório.]}",
    "{refresh: [Este campo é obrigatório.]}",
    "{detail: Usuário e/ou senha incorreto(s)}",
  ];

  Future<Map<String, dynamic>> xApi({
    required String apiUrl,
    required String method,
    required Map<String, dynamic>? body,
  }) async {
    http.Response response;

    switch (method) {
      case "get":
        response = await client.get(
          Uri.parse('$url$apiUrl'),
          headers: {"ContentType": "application/json"},
        );
      case "post":
        response = await client.post(
          Uri.parse('$url$apiUrl'),
          headers: {"ContentType": "application/json"},
          body: body,
        );
      default:
        //TODO: Redo this error handling.
        response = {"Error": "Method not defined"} as http.Response;
    }

    Map<String, dynamic> content = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode != 200) {
      String error = content.toString();

      if (errorMessages.contains(error)){
        print("object");
        return {"Error": error};
      }
      else{
        throw HttpException(response.body);
      }
    }

    return content;
  }
}

class UserNotFindException implements Exception {
  //TODO: Implement this class.
}
