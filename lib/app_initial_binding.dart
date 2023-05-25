import 'package:get/get.dart';
import 'package:local_database/local_database.dart';
import 'package:sheryan_admin/app/core/dio/factory.dart';
import 'package:sheryan_admin/app/core/repositories/constants_repository.dart';
import 'package:sheryan_admin/app/core/repositories/user_repository.dart';
import 'package:sheryan_admin/app/modules/drawer/main_drawer/main_drawer_binding.dart';

class AppInitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(
      LocalDatabase.instance,
      permanent: true,
    );
    Get.put(
      UserRepository(),
      permanent: true,
    );
    Get.put(
      DioFactory.dioSetUp(userRepository: Get.find<UserRepository>()),
      permanent: true,
    );
    Get.put(
      ConstantsRepository(),
      permanent: true,
    );

    MainDrawerBinding().dependencies();
  }
}
