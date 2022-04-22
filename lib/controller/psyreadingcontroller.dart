import 'package:get/get.dart';
import 'package:serenity/model/paymentreading_model.dart';
import 'package:serenity/model/psyreading_controller.dart';
import 'package:serenity/model/userreading_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class PsyReadingController extends GetxController {
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  List<ViewPsyModel> userreading = <ViewPsyModel>[];

  Future<void> getProfile() async {
    loading = true;
    update();

    var response = await RemoteServices.getPsyProfile();
    userreading = viewPsyModelFromJson(response);
    getTotalUser();
    loading = false;
    update();
  }

  double total = 0;

  getTotalUser() {
    for (var item in userreading) {
      total = total + 1;
    }
    update();
  }
}
