import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:io';

import 'package:hive_flutter/adapters.dart';
import 'package:local_database/config/local_database_exception.dart';
import 'package:local_database/config/local_database_routs.dart';
import 'package:local_database/config/logger.dart';
import 'package:local_database/models/result_model.dart';

part '../boxes/config_box.dart';
part '../boxes/constants_box.dart';
part '../boxes/fixed_time_box.dart';
part '../boxes/key_box.dart';
part '../boxes/ride_box.dart';
part '../boxes/user_box.dart';

class LocalDatabase
    with _UserBox, _KeyBox, _FixedTimeBox, _ConstantBox, _RideBox, _ConfigBox {
  LocalDatabase._internal();
  static final LocalDatabase instance = LocalDatabase._internal();

  Future<void> _clearDB() async {
    try {
      await _removeUser();
      await _removeKey();
      await _removeFixedTime();
      await _removeConstant();
      await _removeRide();
      await _removeConfig();
    } on LocalDatabaseException catch (e) {
      throw LocalDatabaseException(e.message);
    }
  }

  Future<Result> post(
    String path, {
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      logger("post: $path", name: "Local Database");
      switch (path) {
        case LocalDatabaseRouts.setUser:
          await _setUser(data);
          break;
        case LocalDatabaseRouts.setConfig:
          await _setConfig(queryParameters!["key"], data);
          break;
        case LocalDatabaseRouts.setRide:
          await _setRide(data);
          break;

        case LocalDatabaseRouts.setConstants:
          await _setConstant(data);
          break;

        case LocalDatabaseRouts.setKey:
          await _setKey({"Key": data});
          break;

        case LocalDatabaseRouts.setFixedTime:
          await _setFixedTime(data);
          break;

        default:
          throw LocalDatabaseException(
              "LocalDatabaseException: path \"$path\" dosn't exist");
      }
      return Result(data: "done");
    } on LocalDatabaseException catch (e) {
      throw LocalDatabaseException(e.message);
    }
  }

  Future<Result> get(
    String path, {
    dynamic queryParameters,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      logger("get: $path", name: "Local Database");
      dynamic data;
      switch (path) {
        case LocalDatabaseRouts.getUser:
          data = _getUser();
          break;
        case LocalDatabaseRouts.getConfig:
          data = _getConfig(queryParameters!["key"]);
          break;

        case LocalDatabaseRouts.getConstants:
          data = _getConstant();
          break;
        case LocalDatabaseRouts.getRide:
          data = _getRide();
          break;

        case LocalDatabaseRouts.getKey:
          data = _getKey()?["Key"];
          break;

        case LocalDatabaseRouts.getFixedTime:
          data = _getFixedTime();
          break;

        default:
          throw LocalDatabaseException(
              "LocalDatabaseException: path \"$path\" dosn't exist");
      }
      if (data == null &&
          path != LocalDatabaseRouts.getKey &&
          path != LocalDatabaseRouts.getConstants &&
          path != LocalDatabaseRouts.getUser &&
          path != LocalDatabaseRouts.getRide &&
          path != LocalDatabaseRouts.getConfig &&
          path != LocalDatabaseRouts.getFixedTime) {
        throw const SocketException("No Result");
      }
      return Result(data: data);
    } on LocalDatabaseException catch (e) {
      throw LocalDatabaseException(e.message);
    }
  }

  Future<Result> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      logger("delete: $path", name: "Local Database");
      switch (path) {
        case LocalDatabaseRouts.clearDB:
          await _clearDB();
          break;
        case LocalDatabaseRouts.deleteRide:
          await _removeRide();
          break;

        default:
          throw LocalDatabaseException(
              "LocalDatabaseException: path \"$path\" dosn't exist");
      }
      return Result(data: "done");
    } on LocalDatabaseException catch (e) {
      throw LocalDatabaseException(e.message);
    }
  }

  bool isOpend = false;
  Future<LocalDatabase> init({DatabaseMode mode = DatabaseMode.release}) async {
    try {
      changeLoggerState(mode);
      await _openDatabaseStore();
      return instance;
    } catch (e) {
      throw LocalDatabaseException(e.toString());
    }
  }

  Future<void> _openDatabaseStore() async {
    try {
      final DateTime dateTime1 = DateTime.now();
      if (isOpend) {
        await Hive.close();
        log("Done", name: "Close DatabaseStores");
      }
      await Hive.initFlutter();
      await _openUserBox();
      await _openKeyBox();
      await _openConstantBox();
      await _openFixedTimeBox();
      await _openRideBox();
      await _openConfigBox();
      isOpend = true;
      final DateTime dateTime2 = DateTime.now();
      log(dateTime2.difference(dateTime1).inMilliseconds.toString(),
          name: "openDatabaseStore Time");
    } catch (e) {
      logger("ObjectBoxException from openDatabaseStore: $e");
      rethrow;
    }
  }
}
