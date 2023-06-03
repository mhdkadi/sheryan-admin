import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheryan_admin/app/core/helpers/data_helper.dart';
import 'package:sheryan_admin/app/core/models/hospital_model.dart';
import 'package:sheryan_admin/app/core/models/pathological_case_model.dart';
import 'package:sheryan_admin/app/core/repositories/constants_repository.dart';
import 'package:sheryan_admin/app/core/repositories/user_repository.dart';
import 'package:sheryan_admin/app/core/services/location_service.dart';
import 'package:sheryan_admin/app/core/services/request_mixin.dart';

import '../../../core/services/getx_state_controller.dart';

class MainHomeController extends GetxStateController
    with GetSingleTickerProviderStateMixin {
  GoogleMapController? mapController;
  final ConstantsRepository constantsRepository;
  final UserRepository userRepository;
  List<PathologicalCase> pathologicalCases = [];
  MainHomeController({
    required this.constantsRepository,
    required this.userRepository,
  });
  @override
  void onInit() {
    getLastState();
    updateCameraPosition();
    getPathologicalCases();
    super.onInit();
  }

  void setMapStyle(GoogleMapController controller, BuildContext context) async {
    final String style = await DefaultAssetBundle.of(context)
        .loadString("assets/jsons/map_style.json");
    controller.setMapStyle(style);
  }

  Future<void> getLastState() async {
    await requestMethod(
      ids: ["getLastState"],
      stateLessIds: ["DriverState"],
      requestType: RequestType.getData,
      function: () async {
        return null;
      },
    );
  }

  LatLng? currentLocation;
  Future<void> updateCameraPosition() async {
    await requestMethod(
      ids: ["myLocation"],
      requestType: RequestType.getData,
      function: () async {
        currentLocation = await LocationService.instance.getCurrentLocation();
        mapController
            ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: currentLocation!,
          zoom: 15,
        )));
        return null;
      },
    );
  }

  Future<void> getPathologicalCases() async {
    await requestMethod(
      ids: ["pathologicalCases"],
      requestType: RequestType.getData,
      function: () async {
        pathologicalCases = await constantsRepository.pathologicalCases();
        return null;
      },
    );
  }

  String hospitalType = "حكومي";
  List<Hospital> hospitals = [];
  Future<void> getHospitals() async {
    await requestMethod(
      ids: ["getHospitals"],
      requestType: RequestType.getData,
      function: () async {
        hospitals = await constantsRepository.hospitals();
        return null;
      },
    );
  }

  Future<void> order({
    required String pathologicalCase,
  }) async {
    await requestMethod(
      ids: ["orderWidget"],
      loadedMessage: "تم استلام طلبك بنجاح المسعف في طريقه إليك",
      requestType: RequestType.getData,
      function: () async {
        await constantsRepository.order(
          level: "level",
          userId: DataHelper.user!.id,
          pathologicalCase: pathologicalCase,
          currentLocation: currentLocation!,
        );
        return null;
      },
    );
  }
}
