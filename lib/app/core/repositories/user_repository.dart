import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:local_database/config/local_database_routs.dart';
import 'package:local_database/models/result_model.dart';

import '../constants/request_routes.dart';
import '../models/user_model.dart';
import '../utils/exceptions.dart';
import 'repository_interface.dart';

class UserRepository extends RepositoryInterface {
  Future<User> register({
    required String username,
    required String password,
    required String phoneNumber,
    required String fcmToken,
    required String fullName,
    required String accountType,
    required LatLng currentLocation,
  }) async {
    try {
      final Response result = await dio.post(
        RequestRoutes.register,
        data: {
          "fullName": fullName,
          "username": username,
          "password": password,
          "phone": phoneNumber,
          "accountType": accountType,
          "status": "offline",
          "location": {
            "lat": currentLocation.latitude,
            "lng": currentLocation.latitude,
          },
          "fcmToken": fcmToken,
        },
      );
      final User user = User.fromMap(result.data);
      await setUser(user);
      return user;
    } catch (error) {
      throw ExceptionHandler(error);
    }
  }

  Future<User> login({
    required String username,
    required String password,
    required String fcmToken,
  }) async {
    try {
      final Response result = await dio.post(
        RequestRoutes.login,
        data: {
          "username": username,
          "password": password,
          'fcmToken': fcmToken,
        },
      );
      final User user = User.fromMap(result.data);
      await setUser(user);
      return user;
    } catch (error) {
      throw ExceptionHandler(error);
    }
  }

  Future<User?> getUser() async {
    try {
      final Result result = await localDatabase.get(LocalDatabaseRouts.getUser);
      if (result.data != null) {
        return User.fromMap(result.data);
      } else {
        return null;
      }
    } catch (error) {
      throw ExceptionHandler(error);
    }
  }

  Future<void> setUser(User user) async {
    try {
      await localDatabase.post(LocalDatabaseRouts.setUser, data: user.toMap());
    } catch (error) {
      throw ExceptionHandler(error);
    }
  }

  Future<void> deleteUser() async {
    try {
      await localDatabase.delete(LocalDatabaseRouts.clearDB);
    } catch (error) {
      throw ExceptionHandler(error);
    }
  }
}
