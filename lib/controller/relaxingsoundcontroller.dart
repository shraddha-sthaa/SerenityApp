import 'package:get/get.dart';
import 'package:serenity/model/relaxingsounds_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class RelaxingSoundPageController extends GetxController {
  bool loading = false;

  bool playing = false;

  @override
  void onInit() {
    super.onInit();
    getRelaxingSounds();
  }

  List<RelaxingSoundModel> relaxingsound = <RelaxingSoundModel>[];

  Future<void> getRelaxingSounds() async {
    loading = true;
    update();

    var response = await RemoteServices.getRelaxingSounds();
    relaxingsound = relaxingSoundModelFromJson(response);

    loading = false;
    update();
  }
}
