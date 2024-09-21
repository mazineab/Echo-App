import 'package:get/get.dart';
import 'package:myapp/common/drawer/custom_drawer_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CustomDrawerController());
  }
}
