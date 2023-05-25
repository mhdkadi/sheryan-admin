import 'package:get/get.dart';
import 'package:sheryan_admin/app/core/services/secure_get_page.dart';
import 'package:sheryan_admin/app/modules/drawer/admins/admins_binding.dart';
import 'package:sheryan_admin/app/modules/drawer/admins/admins_view.dart';
import 'package:sheryan_admin/app/modules/drawer/hospitals/hospitals_binding.dart';
import 'package:sheryan_admin/app/modules/drawer/hospitals/hospitals_view.dart';
import 'package:sheryan_admin/app/modules/drawer/paramedics/paramedics_binding.dart';
import 'package:sheryan_admin/app/modules/drawer/paramedics/paramedics_view.dart';
import 'package:sheryan_admin/app/modules/drawer/shared/constant/drawer_routes.dart';

part 'shared/drawer_pages.dart';

class DrawerModule {
  static List<GetPage> get drawerPages => _DrawerPages.drawerPages;
}
