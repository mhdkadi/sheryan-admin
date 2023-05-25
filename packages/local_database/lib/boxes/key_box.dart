part of '../config/main_service.dart';

mixin _KeyBox {
  late Box<Map<dynamic, dynamic>> _key;

  Future<void> _openKeyBox() async {
    try {
      _key = await Hive.openBox<Map<dynamic, dynamic>>('keyBox');
    } catch (e) {
      throw LocalDatabaseException("Failed to call: openKeyBox");
    }
  }

  Map<String, dynamic>? _getKey() {
    try {
      final String string = jsonEncode(_key.get('key'));
      return jsonDecode(string);
    } catch (e) {
      throw LocalDatabaseException("Failed to call: getKey");
    }
  }

  Future<void> _setKey(Map<String, dynamic> key) async {
    try {
      await _key.put('key', key);
    } catch (e) {
      throw LocalDatabaseException("Failed to call: setKey");
    }
  }

  Future<void> _removeKey() async {
    try {
      await _key.delete('key');
    } catch (e) {
      throw LocalDatabaseException("Failed to call: removeKey");
    }
  }
}
