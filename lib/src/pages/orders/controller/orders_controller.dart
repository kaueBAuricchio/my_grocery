import 'package:get/get.dart';
import 'package:my_grocery/src/models/order_model.dart';
import 'package:my_grocery/src/pages/auth/controller/auth_controller.dart';
import 'package:my_grocery/src/pages/orders/repository/order_repository.dart';
import 'package:my_grocery/src/pages/orders/result/orders_result.dart';
import 'package:my_grocery/src/services/utils_services.dart';

class OrdersController extends GetxController {
  List<OrderModel> allOrders = [];
  final orderRepository = OrderRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  @override
  void onInit() {
    super.onInit();

    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrdersResult<List<OrderModel>> result = await orderRepository.getAllOrders(
        userId: authController.userModel.id!,
        token: authController.userModel.token!);

    result.when(success: (orders) {
      allOrders = orders
          .sort((a, b) => b.createdDateTime!.compareTo(a.createdDateTime!));
      update();
    }, error: (message) {
      utilsServices.showToast(message: message, isError: true);
    });
  }
}
