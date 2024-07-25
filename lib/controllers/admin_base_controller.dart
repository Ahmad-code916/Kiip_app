import 'package:get/get.dart';
import '../models/user_model.dart';
class UserBaseController extends GetxController {
  var userModel = UserModel().obs;
  Map<String, UserModel> users = {};

  static UserModel? getUser(String uid) {
    var userController = Get.put(UserBaseController(), permanent: true);
    return userController.users[uid];
  }

  static void updateUser(UserModel userModel) {
    var userController = Get.put(UserBaseController(), permanent: true);
    userController.userModel.value = userModel;
    userController.update();
  }

  static Rx<UserModel> get userData {
    return Get
        .put(UserBaseController(), permanent: true)
        .userModel;
  }
}