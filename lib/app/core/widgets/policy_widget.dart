import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';
import '../utils/intl.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions(
      {required this.policy, required this.title, Key? key})
      : super(key: key);

  final String policy;
  final String title;

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool isAr = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary),
        ),
        backgroundColor: AppColors.background,
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: getTextDirection(
          widget.policy,
        ),
        child: Markdown(
          selectable: true,
          shrinkWrap: true,
          data: widget.policy,
        ),
      ),
    );
  }
}
