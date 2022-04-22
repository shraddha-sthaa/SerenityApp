import 'package:get/get.dart';
import 'package:serenity/model/paymentreading_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class PaymentReadingController extends GetxController {
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    getPayment();
  }

  List<PaymentReadingModel> paymentreading = <PaymentReadingModel>[];

  Future<void> getPayment() async {
    loading = true;
    update();

    var response = await RemoteServices.getPayment();
    paymentreading = paymentReadingModelFromJson(response);
    getTotalEarning();
    loading = false;
    update();
  }

  double total = 0;

  getTotalEarning() {
    for (var item in paymentreading) {
      total = total + double.parse(item.totalAmount);
    }
    update();
  }
}
