import 'package:get/get.dart';
import 'package:serenity/model/notification_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class NotificationPageController extends GetxController {
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    getNotification();
  }

  List<NotificationModel> notification = <NotificationModel>[];

  Future<void> getNotification() async {
    loading = true;
    update();

    var response = await RemoteServices.getNotification();
    notification = notificationModelFromJson(response);

    loading = false;
    update();
  }
}
