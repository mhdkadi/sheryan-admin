part of '../config/main_service.dart';

mixin _RideBox {
  late Box<Map<dynamic, dynamic>> _ride;

  Future<void> _openRideBox() async {
    try {
      _ride = await Hive.openBox<Map<dynamic, dynamic>>('rideBox');
    } catch (e) {
      throw LocalDatabaseException("Failed to call: openRideBox");
    }
  }

  Map<String, dynamic>? _getRide() {
    try {
      final String string = jsonEncode(_ride.get('ride'));
      return jsonDecode(string);
    } catch (e) {
      throw LocalDatabaseException("Failed to call: getRide");
    }
  }

  Future<void> _setRide(Map<String, dynamic> ride) async {
    try {
      await _ride.put("ride", ride);
    } catch (e) {
      throw LocalDatabaseException("Failed to call: setRide");
    }
  }

  Future<void> _removeRide() async {
    try {
      await _ride.delete("ride");
    } catch (e) {
      throw LocalDatabaseException("Failed to call: removeRide");
    }
  }
}
