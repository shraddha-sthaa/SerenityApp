import 'package:get/get.dart';
import 'package:serenity/model/psychat_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class ChatStreamController extends GetxController {
  List<PsyChatModel> chats = <PsyChatModel>[];

  Future<List<PsyChatModel>> getChats(String psyId, String user) async {
    var response = await RemoteServices.fetchChat(psyId, user);
    chats = psyChatModelFromJson(response);
    update();
    return chats;
  }
}
