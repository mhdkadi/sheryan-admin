import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/size_configration.dart';
import '../../../core/widgets/widget_state.dart';
import 'wrapper_controller.dart';

class WrapperView extends GetView<WrapperController> {
  const WrapperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenSizer(builder: (CustomSize customSize) {
        return StateBuilder<WrapperController>(
            id: "WrapperView",
            disableState: true,
            builder: (widgetState, controller) {
              return SizedBox(
                width: customSize.screenWidth,
                child: Column(
                  children: [
                    const Spacer(),
                    const SizedBox(height: 45),
                    const SizedBox(
                      width: 200,
                      height: 200,
                      child: Placeholder(),
                    ),
                    const SizedBox(height: 20),
                    if (widgetState == WidgetState.error)
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                            onPressed: () {
                              controller.initWrapper();
                            },
                            child: const Text("إعادة المحاولة")),
                      )
                    else
                      const SizedBox(height: 45),
                    const Spacer(),
                  ],
                ),
              );
            });
      }),
    );
  }
}
