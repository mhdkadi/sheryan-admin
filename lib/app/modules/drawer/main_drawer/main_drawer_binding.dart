import 'package:get/get.dart';
import 'package:sheryan_admin/app/core/repositories/user_repository.dart';

import 'main_drawer_controller.dart';

class MainDrawerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      MainDrawerController(userRepository: Get.find<UserRepository>()),
      permanent: true,
    );
  }
}
