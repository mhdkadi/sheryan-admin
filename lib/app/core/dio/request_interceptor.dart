import 'package:dio/dio.dart';

import '../utils/logger.dart';

class RequestInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response != null) {
      logger(
        '\npath => ${err.requestOptions.path}\nmessage => ${err.response!.data}\ncode => ${err.response!.statusCode}\ntype => ${err.type}\n',
        name: "Error",
      );
    } else {
      logger(
        '\npath => ${err.requestOptions.path}\nmessage => ${err.message}\ncode => UnKnown\ntype => ${err.type}\n',
        name: "Error",
      );
    }
    super.onError(err, handler);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    logger(options.path, name: "RequestInterceptor");
    logger(
      '\npath => ${options.path}\nheaders => ${options.headers}\ndata => ${options.data}\nqueryParameters => ${options.queryParameters}\n',
      name: "Request",
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.extra['isFile'] != null) {
      logger(
        '\npath => ${response.requestOptions.path}\n@statusCode => ${response.statusCode}\n@data => File\n',
        name: "Response",
      );
    } else {
      logger(
        '\npath => ${response.requestOptions.path}\nstatusCode => ${response.statusCode}\ndata => ${response.data}\n',
        name: "Response",
      );
    }

    super.onResponse(response, handler);
  }
}
