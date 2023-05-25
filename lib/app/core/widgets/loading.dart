import 'package:flutter/material.dart';
import 'package:sheryan_admin/app/core/theme/colors.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: AppColors.secondry,
    ));
  }
}
