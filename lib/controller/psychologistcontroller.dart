import 'package:get/get.dart';
import 'package:serenity/model/psychologist_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class PsychologistPageController extends GetxController {
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    getPsychologist();
  }

  List<PsychologistModel> psychologist = <PsychologistModel>[];

  Future<void> getPsychologist() async {
    loading = true;
    update();

    var response = await RemoteServices.getPsychologist();
    psychologist = psychologistModelFromJson(response);

    loading = false;
    update();
  }
}
