import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../modules/auth/shared/constant/auth_routes.dart';
import '../helpers/data_helper.dart';

class SecureGetPage<T> extends GetPage<T> {
  SecureGetPage({
    required super.name,
    required super.page,
    super.binding,
    List<GetMiddleware>? middlewares,
    super.transition,
  }) : super(
          middlewares: middlewares != null
              ? [...middlewares]
              : [
                  EnsureLogedin(),
                ],
        );
}

class EnsureLogedin extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (route != AuthRoutes.wrapperRoute &&
        route != AuthRoutes.loginRoute &&
        DataHelper.user == null) {
      return const RouteSettings(name: AuthRoutes.loginRoute);
    } else {
      return null;
    }
  }
}
