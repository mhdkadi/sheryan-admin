import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:local_database/config/main_service.dart';

abstract class RepositoryInterface {
  LocalDatabase get localDatabase => Get.find<LocalDatabase>();
  Dio get dio => Get.find<Dio>();
  Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com').timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw const SocketException("Not Connected");
        },
      );
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
