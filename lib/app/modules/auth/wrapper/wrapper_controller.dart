import 'package:get/get.dart';
import 'package:sheryan_admin/app/core/helpers/data_helper.dart';
import 'package:sheryan_admin/app/core/repositories/user_repository.dart';
import 'package:sheryan_admin/app/core/widgets/widget_state.dart';
import 'package:sheryan_admin/app/modules/home/home_module.dart';

import '../../../core/repositories/constants_repository.dart';
import '../../../core/services/getx_state_controller.dart';

class WrapperController extends GetxStateController {
  WrapperController({
    required this.constantsRepository,
    required this.userRepository,
  });

  final ConstantsRepository constantsRepository;
  final UserRepository userRepository;
  bool isUpdateBottomSheetOpen = false;
  @override
  void onInit() async {
    await initWrapper();
    super.onInit();
  }

  Future<void> initWrapper() async {
    try {
      updateState(["WrapperView"], WidgetState.loading);
      DataHelper.reset();
      DataHelper.user = await Get.find<UserRepository>().getUser();

      await Get.offAndToNamed(HomeModule.homeInitialRoute);
    } catch (e) {
      updateState(["WrapperView"], WidgetState.error);
    }
  }
}
