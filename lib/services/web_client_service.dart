import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';

import 'http_interceptors_service.dart';

class WebClient {
  static const String url = 'http://localhost:8000/';
  // TODO: Read information from an external parameter.

  http.Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
      requestTimeout: const Duration(seconds: 3));
}
