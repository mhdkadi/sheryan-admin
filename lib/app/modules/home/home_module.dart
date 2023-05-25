import 'package:get/get.dart';

import '../../core/services/secure_get_page.dart';
import 'main_home/home_binding.dart';
import 'main_home/home_view.dart';
import 'shared/constant/home_routes.dart';

part 'shared/home_pages.dart';

class HomeModule {
  static String get homeInitialRoute => HomeRoutes.mainHomeRoute;
  static List<GetPage> get homePages => _HomePages.homePages;
}
