import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheryan_admin/app/core/constants/request_routes.dart';
import 'package:sheryan_admin/app/core/models/hospital_model.dart';
import 'package:sheryan_admin/app/core/models/notification_model.dart';
import 'package:sheryan_admin/app/core/models/order_model.dart';
import 'package:sheryan_admin/app/core/models/pathological_case_model.dart';
import 'package:sheryan_admin/app/core/utils/exceptions.dart';

import 'repository_interface.dart';

class ConstantsRepository extends RepositoryInterface {
  Future<void> order({
    required String level,
    required String userId,
    required String pathologicalCase,
    required LatLng currentLocation,
  }) async {
    try {
      await dio.post(
        RequestRoutes.order,
        data: {
          "level": level,
          "status": "toUser",
          "location": {
            "lat": currentLocation.latitude,
            "lng": currentLocation.longitude,
          },
          "user": userId,
          "pathologicalCase": pathologicalCase,
        },
      );
    } catch (error) {
      throw ExceptionHandler(error);
    }
  }

  Future<List<PathologicalCase>> pathologicalCases() async {
    try {
      Response response =
          await dio.get(RequestRoutes.pathologicalCases, queryParameters: {
        "page": 0,
        "limit": 100,
      });
      return PathologicalCase.pathologicalCases(
          response.data["pathologicalCases"]);
    } catch (error) {
      throw ExceptionHandler(error);
    }
  }

  Future<List<NotificationModel>> getNotifications(
      {required String userId}) async {
    try {
      Response response = await dio.get(
        RequestRoutes.notification,
        queryParameters: {
          "page": 0,
          "limit": 100,
          "user": userId,
        },
      );
      return NotificationModel.notifications(response.data["notifications"]);
    } catch (error) {
      throw ExceptionHandler(error);
    }
  }

  Future<List<Order>> getOrders({
    required String userId,
  }) async {
    try {
      Response response = await dio.get(
        RequestRoutes.order,
        queryParameters: {
          "page": 0,
          "limit": 100,
          "user": userId,
        },
      );
      return Order.orders(response.data["orders"]);
    } catch (error) {
      throw ExceptionHandler(error);
    }
  }

  Future<List<Hospital>> hospitals() async {
    try {
      Response response = await dio.get(RequestRoutes.hospital);
      return Hospital.hospitals(response.data);
    } catch (error) {
      throw ExceptionHandler(error);
    }
  }
}
