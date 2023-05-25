import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheryan_admin/app/core/repositories/user_repository.dart';
import 'package:sheryan_admin/app/core/services/location_service.dart';
import 'package:sheryan_admin/app/core/services/notifications/firebase_cloud_messaging.dart';

import '../../../core/services/getx_state_controller.dart';
import '../../../core/services/request_mixin.dart';

class AdminsController extends GetxStateController {
  final UserRepository userRepository;
  AdminsController({
    required this.userRepository,
  });
  Future<void> register({
    required String username,
    required String password,
    required String phoneNumber,
    required String fullName,
  }) async {
    await requestMethod(
      ids: ["RegisterView"],
      loadedMessage: "تم إنشاء الحساب بنجاح",
      requestType: RequestType.getData,
      function: () async {
        final LatLng currentLocation =
            await LocationService.instance.getCurrentLocation();
        final String fcmToken =
            await NotificationService.instance.getFcmToken();
        await userRepository.register(
          username: username,
          password: password,
          phoneNumber: phoneNumber,
          fcmToken: fcmToken,
          fullName: fullName,
          currentLocation: currentLocation,
          accountType: "admin",
        );
        Get.back();
        return null;
      },
    );
  }
}
