import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:sheryan_admin/app/core/helpers/data_helper.dart';
import 'package:sheryan_admin/app/modules/drawer/shared/constant/drawer_routes.dart';

import '../../../core/theme/colors.dart';
import '../../../core/widgets/elevated_button.dart';
import '../../../core/widgets/widget_state.dart';
import 'main_drawer_controller.dart';

class MainDrawerView extends GetView<MainDrawerController> {
  const MainDrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateBuilder<MainDrawerController>(
        id: "MainDrawerView",
        disableState: true,
        initialWidgetState: WidgetState.loaded,
        builder: (widgetState, controller) {
          return Container(
            color: AppColors.background,
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundColor: AppColors.font,
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: AppColors.background,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DataHelper.user!.fullName,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  DataHelper.user!.phone
                                      .replaceFirst("963", "0"),
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 190,
                        child: ListView(
                          children: [
                            drawerItem(
                              icon: Icons.group,
                              title: "المشرفين",
                              route: DrawerRoutes.adminsRoute,
                              context: context,
                            ),
                            drawerItem(
                              icon: Icons.fire_truck_outlined,
                              title: "سيارات الإسعاف",
                              route: DrawerRoutes.paramedicsRoute,
                              context: context,
                            ),
                            // drawerItem(
                            //   icon: Icons.location_city,
                            //   title: "المشافي",
                            //   route: DrawerRoutes.hospitalsRoute,
                            //   context: context,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: InkWell(
                        onTap: () {
                          ZoomDrawer.of(context)?.close();
                        },
                        child: const Icon(
                          Icons.close,
                          color: AppColors.secondry,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 45,
                          child: StateBuilder<MainDrawerController>(
                            id: "logOutButton",
                            disableState: true,
                            initialWidgetState: WidgetState.loaded,
                            builder: (widgetState, controller) {
                              return ElevatedStateButton(
                                color: AppColors.secondry,
                                widgetState: widgetState,
                                onPressed: () {
                                  logOutDialog(
                                      context: context,
                                      onConfirm: () {
                                        controller.logOut(context);
                                      });
                                },
                                child: Row(
                                  children: [
                                    const Text(
                                      "تسجيل خروج",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Icon(
                                      Icons.logout,
                                      color: Theme.of(context).primaryColor,
                                      size: 27,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget drawerItem({
    required IconData icon,
    required String title,
    required String route,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, top: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.secondry,
        ),
        onPressed: () async {
          Get.toNamed(route);
          ZoomDrawer.of(context)?.close();
        },
        child: Row(
          children: [
            SizedBox(
              width: 30,
              child: Icon(
                icon,
                color: AppColors.font,
                size: 30,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.font,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logOutDialog({
    required BuildContext context,
    required Function onConfirm,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: AppColors.background,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width - 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'تسجيل خروج',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 5),
                  child: Text('هل أنت متأكد من تسجيل الخروج؟'),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      width: (MediaQuery.of(context).size.width - 150) * 0.5,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.backgroundTextFilled)),
                          onPressed: () {
                            Get.back();
                            onConfirm();
                            FocusScope.of(context).unfocus();
                          },
                          child: const Text("تسجيل خروج")),
                    ),
                    SizedBox(
                      height: 50,
                      width: (MediaQuery.of(context).size.width - 150) * 0.5,
                      child: ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.secondry)),
                        child: const Text("عودة"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

AppBar drawerAppBar(String title, [double elevation = 4]) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w900,
      ),
    ),
    centerTitle: true,
    elevation: elevation,
    backgroundColor: AppColors.background,
  );
}
