import 'package:get/get.dart';
import 'package:serenity/model/blog_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class BlogPageController extends GetxController {
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    getBlog();
  }

  List<BlogModel> blog = <BlogModel>[];

  Future<void> getBlog() async {
    loading = true;
    update();

    var response = await RemoteServices.getBlog();
    blog = blogModelFromJson(response);

    loading = false;
    update();
  }
}
