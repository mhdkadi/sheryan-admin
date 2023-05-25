import 'package:get/get.dart';
import 'package:sheryan_admin/app/core/repositories/constants_repository.dart';
import 'package:sheryan_admin/app/core/repositories/user_repository.dart';

import 'home_controller.dart';

class MainHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      MainHomeController(
        constantsRepository: Get.find<ConstantsRepository>(),
        userRepository: Get.find<UserRepository>(),
      ),
    );
  }
}
