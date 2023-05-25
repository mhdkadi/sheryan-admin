// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/widget_state.dart';
import 'hospitals_controller.dart';

class HospitalsView extends GetView<HospitalsController> {
  const HospitalsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StateBuilder<HospitalsController>(
        id: "HospitalsView",
        builder: (widgetState, controller) {
          return const Center(child: SizedBox());
        },
      ),
    );
  }
}
