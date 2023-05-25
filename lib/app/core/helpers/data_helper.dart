import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sheryan_admin/app/core/models/user_model.dart';

class DataHelper {
  static late PackageInfo packageInfo;
  static User? user;
  static void reset() {
    user = null;
    currentLocation = const LatLng(
      36,
      36,
    );
  }

  static LatLng currentLocation = const LatLng(
    36,
    36,
  );
}
