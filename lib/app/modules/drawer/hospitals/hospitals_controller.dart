import '../../../core/services/getx_state_controller.dart';
import '../../../core/services/request_mixin.dart';

class HospitalsController extends GetxStateController {
  @override
  void onInit() {
    getHospitals();
    super.onInit();
  }

  Future<void> getHospitals() async {
    await requestMethod(
      ids: ["HospitalsView"],
      requestType: RequestType.getData,
      function: () async {
        return null;
      },
    );
  }
}
