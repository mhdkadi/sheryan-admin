part of '../config/main_service.dart';

mixin _UserBox {
  late Box<Map<dynamic, dynamic>> _user;

  Future<void> _openUserBox() async {
    try {
      _user = await Hive.openBox<Map<dynamic, dynamic>>('userBox');
    } catch (e) {
      throw LocalDatabaseException("Failed to call: openUserBox");
    }
  }

  Map<String, dynamic>? _getUser() {
    try {
      final String string = jsonEncode(_user.get('user'));
      return jsonDecode(string);
    } catch (e) {
      throw LocalDatabaseException("Failed to call: getUser");
    }
  }

  Future<void> _setUser(Map<String, dynamic> user) async {
    try {
      await _user.put("user", user);
    } catch (e) {
      throw LocalDatabaseException("Failed to call: setUser");
    }
  }

  Future<void> _removeUser() async {
    try {
      await _user.delete("user");
    } catch (e) {
      throw LocalDatabaseException("Failed to call: removeUser");
    }
  }
}
