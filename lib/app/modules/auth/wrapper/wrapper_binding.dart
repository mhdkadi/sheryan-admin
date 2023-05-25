import 'package:get/get.dart';
import 'package:sheryan_admin/app/core/repositories/user_repository.dart';

import '../../../core/repositories/constants_repository.dart';
import 'wrapper_controller.dart';

class WrapperBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      WrapperController(
        constantsRepository: Get.find<ConstantsRepository>(),
        userRepository: Get.find<UserRepository>(),
      ),
    );
  }
}
