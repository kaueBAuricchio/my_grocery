import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:my_grocery/src/pages/base/controller/base_controller.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BaseController());
  }
}
