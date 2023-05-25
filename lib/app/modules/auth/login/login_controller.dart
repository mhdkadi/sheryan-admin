import 'package:get/get.dart';
import 'package:sheryan_admin/app/core/repositories/user_repository.dart';
import 'package:sheryan_admin/app/core/services/notifications/firebase_cloud_messaging.dart';
import 'package:sheryan_admin/app/modules/auth/auth_module.dart';

import '../../../core/services/getx_state_controller.dart';
import '../../../core/services/request_mixin.dart';

class LoginController extends GetxStateController {
  UserRepository userRepository;
  LoginController({
    required this.userRepository,
  });
  Future<void> login({
    required String username,
    required String password,
  }) async {
    await requestMethod(
      ids: ["LoginView"],
      requestType: RequestType.getData,
      function: () async {
        final String fcmToken =
            await NotificationService.instance.getFcmToken();
        await userRepository.login(
          username: username,
          password: password,
          fcmToken: fcmToken,
        );
        Get.offAllNamed(AuthModule.authInitialRoute);
        return null;
      },
    );
  }
}
