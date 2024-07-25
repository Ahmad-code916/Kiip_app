
import 'package:get/get.dart';

class ScreenThreeController extends GetxController {

  var selectedIndex = 0.obs;

  void changeIndex (index) {

    selectedIndex.value = index;

  }

}