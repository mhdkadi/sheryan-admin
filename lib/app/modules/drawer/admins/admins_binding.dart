import 'package:get/get.dart';
import 'package:sheryan_admin/app/core/repositories/user_repository.dart';

import 'admins_controller.dart';

class AdminsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      AdminsController(userRepository: Get.find<UserRepository>()),
    );
  }
}
