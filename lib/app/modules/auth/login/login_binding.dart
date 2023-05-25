import 'package:get/get.dart';
import 'package:sheryan_admin/app/core/repositories/user_repository.dart';

import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      LoginController(userRepository: Get.find<UserRepository>()),
    );
  }
}
