import 'package:flutter/material.dart';
import 'package:sheryan_admin/app/core/theme/colors.dart';

import '../services/size_configration.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({
    required this.onRetryFunction,
    Key? key,
  }) : super(key: key);

  final Function? onRetryFunction;

  @override
  Widget build(BuildContext context) {
    return ScreenSizer(builder: (customSize) {
      return SizedBox(
        width: customSize.screenWidth,
        height: customSize.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "لايوجد اتصال بالإنترنت",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(height: 20),
            onRetryFunction == null
                ? const SizedBox()
                : OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.secondry,
                      ),
                    ),
                    onPressed: () => onRetryFunction!(),
                    child: const Text(
                      "إعادة المحاولة",
                      style: TextStyle(
                        color: AppColors.secondry,
                      ),
                    ),
                  ),
          ],
        ),
      );
    });
  }
}
