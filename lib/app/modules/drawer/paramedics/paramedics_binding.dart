import 'package:get/get.dart';
import 'package:sheryan_admin/app/core/repositories/user_repository.dart';

import 'paramedics_controller.dart';

class ParamedicsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      ParamedicsController(userRepository: Get.find<UserRepository>()),
    );
  }
}
