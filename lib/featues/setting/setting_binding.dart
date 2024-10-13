import 'package:get/get.dart';
import 'package:myapp/featues/setting/controller/setting_controller.dart';

class SettingBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SettingController());
  }

}