import 'package:dio/dio.dart';

import '../constants/urls.dart';
import '../repositories/user_repository.dart';
import 'request_interceptor.dart';

class DioFactory {
  static Dio dioSetUp({required UserRepository userRepository}) {
    final BaseOptions options = BaseOptions(
      baseUrl: ConstUrls.baseUrl(),
      sendTimeout: const Duration(seconds: 10),
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      contentType: "application/json",
    );
    final Dio dio = Dio(options);
    // (dio.httpClientAdapter).IOHttpClientAdapter().onHttpClientCreate =
    //     (client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) {
    //     return false;
    //   };
    //   return client;
    // };
    dio.interceptors.addAll([
      RequestInterceptor(),
    ]);
    return dio;
  }
}
