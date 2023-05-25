part of '../config/main_service.dart';

mixin _ConstantBox {
  late Box<Map<dynamic, dynamic>> _constant;

  Future<void> _openConstantBox() async {
    try {
      _constant = await Hive.openBox<Map<dynamic, dynamic>>('constantBox');
    } catch (e) {
      throw LocalDatabaseException("Failed to call: openConstantBox");
    }
  }

  Map<String, dynamic>? _getConstant() {
    try {
      final String string = jsonEncode(_constant.get('constant'));
      return jsonDecode(string);
    } catch (e) {
      throw LocalDatabaseException("Failed to call: getConstant");
    }
  }

  Future<void> _setConstant(Map<String, dynamic> constant) async {
    try {
      await _constant.put('constant', constant);
    } catch (e) {
      throw LocalDatabaseException("Failed to call: setConstant");
    }
  }

  Future<void> _removeConstant() async {
    try {
      await _constant.delete('constant');
    } catch (e) {
      throw LocalDatabaseException("Failed to call: removeConstant");
    }
  }
}
