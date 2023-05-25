part of '../config/main_service.dart';

mixin _FixedTimeBox {
  late Box<int> _fixedTime;

  Future<void> _openFixedTimeBox() async {
    try {
      _fixedTime = await Hive.openBox<int>('fixedTimeBox');
    } catch (e) {
      throw LocalDatabaseException("Failed to call: openFixedTimeBox");
    }
  }

  int? _getFixedTime() {
    try {
      final String string = jsonEncode(_fixedTime.get('fixedTime'));
      return jsonDecode(string);
    } catch (e) {
      throw LocalDatabaseException("Failed to call: getFixedTime");
    }
  }

  Future<void> _setFixedTime(int fixedTime) async {
    try {
      await _fixedTime.put('fixedTime', fixedTime);
    } catch (e) {
      throw LocalDatabaseException("Failed to call: setFixedTime");
    }
  }

  Future<void> _removeFixedTime() async {
    try {
      await _fixedTime.delete('fixedTime');
    } catch (e) {
      throw LocalDatabaseException("Failed to call: removeFixedTime");
    }
  }
}
