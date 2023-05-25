// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer';

enum DatabaseMode { development, test, release }

DatabaseMode _mode = DatabaseMode.release;
void changeLoggerState(DatabaseMode mode) => _mode = mode;
void logger(
  String message, {
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  String name = '',
  Zone? zone,
  Object? error,
  StackTrace? stackTrace,
}) {
  // if (_mode == DatabaseMode.development) {
  log(message,
      error: error,
      level: level,
      name: name,
      sequenceNumber: sequenceNumber,
      time: time,
      zone: zone,
      stackTrace: stackTrace);
  // } else if (_mode == DatabaseMode.development) {
  //   print('''
  //   message: $message
  //   time: $time
  //   sequenceNumber: $sequenceNumber
  //   level: $level
  //   name: $name
  //   zone: $zone
  //   error: $error
  //   stackTrace: $stackTrace
  //   ''');
  // } else {
  //   debugPrint = (String? message, {int? wrapWidth}) {};
  // }
}
