// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sheryan_admin/app/core/services/size_configration.dart';
import 'package:sheryan_admin/app/core/theme/colors.dart';
import 'package:sheryan_admin/app/core/widgets/elevated_button.dart';
import 'package:sheryan_admin/app/core/widgets/input_fields.dart';

import '../../../core/widgets/widget_state.dart';
import 'paramedics_controller.dart';

class ParamedicsView extends GetView<ParamedicsController> {
  ParamedicsView({Key? key}) : super(key: key);

  final registerForm = FormGroup({
    "username": FormControl<String>(
      validators: [
        Validators.required,
        Validators.maxLength(40),
      ],
    ),
    "password": FormControl<String>(
      validators: [
        Validators.required,
        Validators.maxLength(40),
      ],
    ),
    "fullName": FormControl<String>(
      validators: [
        Validators.required,
        Validators.maxLength(40),
      ],
    ),
    "phone": FormControl<String>(
      validators: [
        Validators.required,
        Validators.maxLength(10),
        phone,
      ],
    )
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "إنشاء حساب",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      body: ScreenSizer(
          constWidth: 50,
          builder: (CustomSize customSize) {
            return StateBuilder<ParamedicsController>(
              id: "RegisterView",
              disableState: true,
              initialWidgetState: WidgetState.loaded,
              builder: (widgetState, controller) {
                return ReactiveForm(
                  formGroup: registerForm,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          "أكمل معلومات المسعف\n لتتمكن من إنشاء حساب جديد",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondry,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        HeaderTextField(
                          widgetState: widgetState,
                          formControlName: "fullName",
                          hintText: "أدخل الاسم الكامل",
                          header: "الاسم الكامل",
                          maxLength: 40,
                          keyboardType: TextInputType.name,
                          validationMessages: {
                            ValidationMessage.required: (_) =>
                                "أدخل الاسم الكامل",
                            ValidationMessage.maxLength: (_) =>
                                "الاسم الكامل طويل جداً",
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),
                        HeaderTextField(
                          widgetState: widgetState,
                          formControlName: "phone",
                          hintText: "أدخل رقم الهاتف",
                          header: "رقم الهاتف",
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          validationMessages: {
                            ValidationMessage.required: (_) =>
                                "أدخل رقم الهاتف",
                            "phone": (_) => "رقم هاتف غير صالح",
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),
                        HeaderTextField(
                          widgetState: widgetState,
                          formControlName: "username",
                          hintText: "أدخل اسم المستخدم",
                          header: "اسم المستخدم",
                          maxLength: 40,
                          keyboardType: TextInputType.name,
                          validationMessages: {
                            ValidationMessage.required: (_) =>
                                "أدخل اسم المستخدم",
                            ValidationMessage.maxLength: (_) =>
                                "اسم المستخدم طويل جداً",
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),
                        HeaderTextField(
                          widgetState: widgetState,
                          formControlName: "password",
                          hintText: "أدخل كلمة المرور",
                          header: "كلمة المرور",
                          maxLength: 40,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          validationMessages: {
                            ValidationMessage.required: (_) =>
                                "أدخل كلمة المرور",
                            ValidationMessage.maxLength: (_) =>
                                "كلمة المرور طويلة جداً",
                          },
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedStateButton(
                            widgetState: widgetState,
                            onPressed: () {
                              if (registerForm.valid) {
                                FocusScope.of(context).unfocus();
                                controller.register(
                                  username:
                                      registerForm.value["username"].toString(),
                                  password:
                                      registerForm.value["password"].toString(),
                                  fullName:
                                      registerForm.value["fullName"].toString(),
                                  phoneNumber:
                                      registerForm.value["phone"].toString(),
                                );
                              } else {
                                registerForm.markAllAsTouched();
                              }
                            },
                            child: const Text(
                              "إنشاء",
                              style: TextStyle(
                                color: AppColors.background,
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
