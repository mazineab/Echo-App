import 'package:get/get.dart';
import 'package:myapp/common/drawer/custom_drawer_controller.dart';
import 'package:myapp/featues/home/controller/current_user_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CurrentUserController());
    // Get.put(CustomDrawerController());
  }
}
