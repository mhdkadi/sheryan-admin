part of '../config/main_service.dart';

mixin _ConfigBox {
  late Box<dynamic> _config;

  Future<void> _openConfigBox() async {
    try {
      _config = await Hive.openBox<dynamic>('configBox');
    } catch (e) {
      throw LocalDatabaseException("Failed to call: openConfigBox");
    }
  }

  dynamic _getConfig(String key) {
    try {
      final String string = jsonEncode(_config.get(key));
      return jsonDecode(string);
    } catch (e) {
      throw LocalDatabaseException("Failed to call: getConfig");
    }
  }

  Future<void> _setConfig(String key, dynamic value) async {
    try {
      await _config.put(key, value);
    } catch (e) {
      throw LocalDatabaseException("Failed to call: setConfig");
    }
  }

  Future<void> _removeConfig() async {
    try {
      await _config.deleteAll(_config.keys);
    } catch (e) {
      throw LocalDatabaseException("Failed to call: removeConfig");
    }
  }
}
