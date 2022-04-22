import 'package:get/get.dart';
import 'package:serenity/model/psyprofile_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class PsychologistListController extends GetxController {
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    getAllPsychologist();
  }

  List<PsyProfileModel> psychologist = <PsyProfileModel>[];

  getAllPsychologist() async {
    loading = true;
    update();
    var response = await RemoteServices.getPsychologistrofile();
    psychologist = psyProfileModelFromJson(response);
    loading = false;
    update();
  }
}
