import 'dart:async';
// import 'dart:convert';
import 'dart:io';

import 'package:dart_acesso_api/services/auth_service_service.dart';

final AuthService authService = AuthService();

Future<void> main(List<String> arguments) async {
  // final AuthService authService = AuthService();

  String username = 'teste1';
  String password = 'dkqp#1111';

  String refreshToken;
  String accessToken;

  // Read token: refresh e access.
  // Map<String, dynamic> token =
  //     await getToken(user: username, password: password);

  // Read token: refresh e access.
  Map<String, dynamic> token = await authService.xApi(
    apiUrl: "/recipes/api/token/",
    method: "post",
    body: {"username": username, "password": password},
  );
  if (token.containsKey("Error")) {
    //TODO: Create the treatment.
    exit(0);
  }

  refreshToken = token['refresh'];
  accessToken = token['access'];

  // Verify token: access
  Map<String, dynamic> verifyToken = await authService.xApi(
    apiUrl: "/recipes/api/token/verify/",
    method: "post",
    body: {"token": accessToken},
  );
  if (verifyToken.containsKey("Error")) {
    //TODO: Create the treatment.
    exit(0);
  }
  print(verifyToken);

  // Refresh token: access
  Map<String, dynamic> getRefreshToken = await authService.xApi(
      apiUrl: "/recipes/api/token/refresh/",
      method: 'post',
      body: {"refresh": refreshToken});
  if (getRefreshToken.containsKey("Error")) {
    //TODO: Create the treatment.
    exit(0);
  }
  accessToken = getRefreshToken['access'];

  // List Recipes
  Map<String, dynamic> recipes = await authService.xApi(
    apiUrl: "/recipes/api/v2/",
    method: "get",
    tokenBearer: accessToken,
    body: {},
  );
  print(recipes['count']);
  print(recipes['next']);
  print(recipes['previous']);
  print(recipes["results"]);

  // Author Update
  Map<String, dynamic> patchAuthor = await authService.xApi(
    apiUrl: "/author/api/2/",
    method: "patch",
    tokenBearer: accessToken,
    body: {"last_name": "Silva", "first_name": "João"},
  );
  print(patchAuthor);

  // Get me
  Map<String, dynamic> me = await authService.xApi(
    apiUrl: "/author/api/me/",
    method: "get",
    tokenBearer: accessToken,
    body: {},
  );
  print(me);

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
