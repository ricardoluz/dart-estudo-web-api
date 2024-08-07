import 'package:http_interceptor/http_interceptor.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor implements InterceptorContract {
  Logger logger = Logger();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    // print(data.toString());
    logger.t(
        "Requisição para ${data.baseUrl}\nCabeçalhos: ${data.headers}\nCorpo: ${data.body}");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    // print(data.toString());
    if (data.statusCode ~/ 100 == 2) {
      // data.headers!.forEach((key, value) => print("$key : $value"));
      // print(data.headers!['date']);
      logger.i(
          "Resposta de ${data.url}\nStatus da resposta: ${data.statusCode}\nCabeçalhos: ${data.headers}\nCorpo: ${data.body}");
      return data;
    } else {
      logger.e(
          "Resposta de ${data.url}\nStatus da resposta: ${data.statusCode}\nCabeçalhos: ${data.headers}\nCorpo: ${data.body}");
    }
    return data;
  }
}
