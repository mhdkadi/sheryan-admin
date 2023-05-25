import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:sheryan_admin/app/core/helpers/data_helper.dart';
import 'package:sheryan_admin/app/core/repositories/user_repository.dart';
import 'package:sheryan_admin/app/core/services/notifications/firebase_cloud_messaging.dart';

import '../../../core/services/getx_state_controller.dart';
import '../../../core/utils/exceptions.dart';
import '../../../core/widgets/app_messenger.dart';
import '../../auth/auth_module.dart';

class MainDrawerController extends GetxStateController {
  final UserRepository userRepository;
  MainDrawerController({required this.userRepository});
  Future<void> logOut(BuildContext context) async {
    try {
      BotToast.showLoading();
      await userRepository.deleteUser();
      await NotificationService.instance.deleteToken();
      ZoomDrawer.of(context)?.close();
      BotToast.closeAllLoading();
      DataHelper.reset();
      Get.offAllNamed(AuthModule.authInitialRoute);
    } on CustomException catch (e) {
      CustomToast.showError(e.error);
    }
  }
}
