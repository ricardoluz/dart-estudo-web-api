import 'dart:async';
// import 'dart:convert';
import 'dart:io';

import 'package:dart_acesso_api/services/auth_service_service.dart';
// import 'package:http/http.dart' as http;

final AuthService authService = AuthService();

Future<void> main(List<String> arguments) async {
  // final AuthService authService = AuthService();

  String username = 'teste1';
  String password = 'dkqp#1111';
  String refreshToken;
  String accessToken;

  // Read token: refresh e access.
  Map<String, dynamic> token = await getToken(user: username, password: password);
  refreshToken = token['refresh'];
  accessToken = token['access'];

  // Verify token: access
  Map<String, dynamic> verifyToken = await authService.xApi(
    apiUrl: "/recipes/api/token/verify/",
    method: "post",
    body: {"token": accessToken},
  );
  print(verifyToken);

  // Refresh token: access
  Map<String, dynamic> getRefreshToken = await authService.xApi(
      apiUrl: "/recipes/api/token/refresh/",
      method: 'post',
      body: {"refresh": refreshToken});
  print(getRefreshToken);
  // accessToken = getRefreshToken['access'];
  // print(accessToken);

  // Verify token: access
  Map<String, dynamic> xxx = await authService.xApi(
    apiUrl: "/recipes/api/v2/",
    method: "get",
    body: {},
  );
  print(xxx);
  print(xxx);

  // String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIyNzkzMjg5LCJpYXQiOjE3MjI3MDM3MjIsImp0aSI6ImM1YjdjZmZlMzRlMzQ0NzE4MjRmNGI0MzI3ZWI0MjllIiwidXNlcl9pZCI6MX0.gBydWd7x5-JISrKrhC2qDGW9NXohGD7pR67h6aoGDig";
  // await authService.testToken(token: token).then(
  //       (successfulLogin) {
  //     if (successfulLogin) {
  //       print('\n\nOk2\n\n');
  //     }
  //   },
  // );

  // var url = Uri.http('localhost:8000', '/recipes/api/token/');
  // var response = await http.post(url, body: {"username": "rluza", "password": "tghy#8483"});
  //
  // Map<String, dynamic> content = json.decode(utf8.decode(response.bodyBytes));
  // String token = content['access'];
}

Future<Map<String, dynamic>> getToken({
  required String user,
  required String password,
}) async {
  Map<String, dynamic> response = await authService.xApi(
    apiUrl: "/recipes/api/token/",
    method: 'post',
    body: {"username": user, "password": password},
  );

  if (response.containsKey("Error")) {
    //TODO: Create the treatment.
    exit(0);
  }
  return response;
}
