part of '../home_module.dart';

class _HomePages {
  _HomePages._();

  static List<GetPage> homePages = [
    SecureGetPage(
      name: HomeRoutes.mainHomeRoute,
      page: () => const MainHomeView(),
      binding: MainHomeBinding(),
      transition: Transition.downToUp,
    ),
  ];
}
