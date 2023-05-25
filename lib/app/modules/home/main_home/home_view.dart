import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sheryan_admin/app/core/helpers/data_helper.dart';
import 'package:sheryan_admin/app/core/services/size_configration.dart';
import 'package:sheryan_admin/app/core/theme/colors.dart';
import 'package:sheryan_admin/app/core/widgets/elevated_button.dart';
import 'package:sheryan_admin/app/core/widgets/input_fields.dart';
import 'package:sheryan_admin/app/core/widgets/widget_state.dart';
import 'package:sheryan_admin/app/modules/drawer/main_drawer/main_drawer_view.dart';

import 'home_controller.dart';

part 'bottom_widgets.dart';
part 'top_widgets.dart';

class MainHomeView extends GetView<MainHomeController> {
  const MainHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: const MainDrawerView(),
      mainScreen: const MainHomeViewBody(),
      borderRadius: 24.0,
      androidCloseOnBackTap: true,
      mainScreenTapClose: true,
      menuScreenWidth: double.infinity,
      disableDragGesture: true,
      isRtl: true,
      showShadow: true,
      angle: 0,
      menuBackgroundColor: AppColors.background,
      drawerShadowsBackgroundColor: AppColors.secondry,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }
}

class MainHomeViewBody extends GetView<MainHomeController> {
  const MainHomeViewBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 130),
        child: AppBar(
          elevation: 0.0,
          toolbarHeight: 130,
          centerTitle: true,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBar(context, controller),
                const SizedBox(height: 10),
                StateBuilder<MainHomeController>(
                    id: "myLocation",
                    disableState: true,
                    initialWidgetState: WidgetState.loaded,
                    builder: (widgetState, controller) {
                      return SizedBox(
                        width: 50,
                        height: 50,
                        child: ElevatedStateButton(
                          widgetState: widgetState,
                          onPressed: () {
                            controller.updateCameraPosition();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.background,
                            padding: EdgeInsets.zero,
                          ),
                          child: const Icon(
                            Icons.my_location_rounded,
                            color: AppColors.font,
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: orderWidget(context: context),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          StateBuilder<MainHomeController>(
            id: "GoogleMapState",
            disableState: true,
            initialWidgetState: WidgetState.loaded,
            builder: (widgetState, controller) {
              return GoogleMap(
                trafficEnabled: true,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer())
                },
                initialCameraPosition: CameraPosition(
                  zoom: 12,
                  target: DataHelper.currentLocation,
                ),
                onCameraMove: (position) {
                  controller.currentLocation = position.target;
                },
                onMapCreated: (mapController) {
                  controller.mapController = mapController;
                  controller.setMapStyle(mapController, context);
                },
              );
            },
          ),
          const Icon(
            Icons.location_on,
            size: 50,
            color: AppColors.path,
          ),
        ],
      ),
    );
  }
}
