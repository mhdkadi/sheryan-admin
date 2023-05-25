part of '../drawer_module.dart';

class _DrawerPages {
  _DrawerPages._();

  static List<GetPage> drawerPages = [
    SecureGetPage(
      name: DrawerRoutes.adminsRoute,
      page: () => AdminsView(),
      binding: AdminsBinding(),
      transition: Transition.rightToLeft,
    ),
    SecureGetPage(
      name: DrawerRoutes.paramedicsRoute,
      page: () => ParamedicsView(),
      binding: ParamedicsBinding(),
      transition: Transition.rightToLeft,
    ),
    SecureGetPage(
      name: DrawerRoutes.hospitalsRoute,
      page: () => const HospitalsView(),
      binding: HospitalsBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
