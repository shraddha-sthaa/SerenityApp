import 'package:get/get.dart';
import 'package:serenity/model/payment_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class PaymentPageController extends GetxController {
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
  }

  List<PaymentModel> payment = <PaymentModel>[];

  Future<void> savePayment(PaymentModel model) async {
    loading = true;
    update();

    var response = await RemoteServices.savePayment(model);

    loading = false;
    update();
  }
}
