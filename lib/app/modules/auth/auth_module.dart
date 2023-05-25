import 'package:get/get.dart';
import 'package:sheryan_admin/app/modules/auth/login/login_binding.dart';
import 'package:sheryan_admin/app/modules/auth/login/login_view.dart';

import '../../core/services/secure_get_page.dart';
import 'shared/constant/auth_routes.dart';
import 'wrapper/wrapper_binding.dart';
import 'wrapper/wrapper_view.dart';

part 'shared/auth_pages.dart';

class AuthModule {
  static String get authInitialRoute => AuthRoutes.wrapperRoute;
  static List<GetPage> get authPages => _AuthPages.authPages;
}
