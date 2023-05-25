import 'globals.dart';

class ConstUrls {
  static String baseUrl() {
    if (appMode != AppMode.release) {
      return "https://api.hala-technology.com/shryan-backend/";
    } else {
      return "";
    }
  }
}
