import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:sheryan_admin/app/core/theme/colors.dart';

import '../constants/globals.dart';
import '../utils/exceptions.dart';

class CustomToast {
  CustomToast.showDefault(String message, [bool showToast = false]) {
    BotToast.closeAllLoading();
    if (showToast) {
      BotToast.showText(text: message);
    } else {
      AppMessenger.message(message);
    }
  }

  CustomToast.showError(CustomError error, [bool showToast = false]) {
    BotToast.closeAllLoading();
    String message = '';
    switch (error) {
      case CustomError.noInternet:
        message = 'تحقق من اتصالك بالإنترنت';
        break;

      case CustomError.wrongCode:
        message = 'رمز تحقق خاطئ أو منتهي';
        break;
      case CustomError.unKnown:
        message = "تحقق من إتصالك بالإنترنت";
        break;
      case CustomError.noParamedic:
        message = "لايوجد مسعف متاح";
        break;

      default:
        message = "تحقق من اتصالك بالانترنت";
    }
    if (showToast) {
      BotToast.showText(text: message, contentColor: AppColors.red);
    } else {
      AppMessenger.error(message);
    }
  }
}

class AppMessenger {
  void showSnackBar(
      {required Widget content,
      SnackBarAction? action,
      Color? backgroundColor,
      Duration duration = const Duration(milliseconds: 4000)}) {
    final ScaffoldMessengerState? currentState = snackbarKey.currentState;
    if (currentState != null) {
      currentState
        ..clearSnackBars()
        ..showSnackBar(SnackBar(
          content: content,
          backgroundColor: backgroundColor ?? AppColors.backgroundTextFilled,
          action: action,
          dismissDirection: DismissDirection.none,
          duration: duration,
        ));
    }
  }

  AppMessenger.error(String message) {
    BotToast.showText(
      text: message,
      contentColor: AppColors.red,
      textStyle: const TextStyle(
        fontSize: 16,
        overflow: TextOverflow.visible,
        fontWeight: FontWeight.bold,
        color: AppColors.font,
      ),
    );
    // showSnackBar(
    //   content: Text(
    //     message,
    //     style: const TextStyle(
    //       fontSize: 16,
    //       overflow: TextOverflow.visible,
    //       fontWeight: FontWeight.bold,
    //       color: AppColors.font,
    //     ),
    //   ),
    //   backgroundColor: AppColors.red,
    // );
  }
  AppMessenger.message(String message) {
    BotToast.showText(
      text: message,
      contentColor: AppColors.backgroundTextFilled,
      textStyle: const TextStyle(
        fontSize: 16,
        overflow: TextOverflow.visible,
        fontWeight: FontWeight.bold,
        color: AppColors.font,
      ),
    );
    // showSnackBar(
    //   content: Text(
    //     message,
    //     style: const TextStyle(
    //       fontSize: 16,
    //       overflow: TextOverflow.visible,
    //       fontWeight: FontWeight.bold,
    //       color: AppColors.font,
    //     ),
    //   ),
    // );
  }
  AppMessenger.warning(String message) {
    BotToast.showText(
      text: message,
      contentColor: AppColors.path,
      textStyle: const TextStyle(
        fontSize: 16,
        overflow: TextOverflow.visible,
        fontWeight: FontWeight.bold,
        color: AppColors.font,
      ),
    );
    // showSnackBar(
    //   content: Text(
    //     message,
    //     style: const TextStyle(
    //       fontSize: 17,
    //       overflow: TextOverflow.visible,
    //       fontWeight: FontWeight.w900,
    //       color: AppColors.font,
    //     ),
    //   ),
    //   backgroundColor: AppColors.path,
    // );
  }
}
