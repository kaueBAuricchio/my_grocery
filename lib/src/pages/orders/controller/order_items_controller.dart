import 'package:get/get.dart';
import 'package:my_grocery/src/models/cart_item_model.dart';
import 'package:my_grocery/src/models/order_model.dart';
import 'package:my_grocery/src/pages/auth/controller/auth_controller.dart';
import 'package:my_grocery/src/pages/orders/repository/order_repository.dart';
import 'package:my_grocery/src/pages/orders/result/orders_result.dart';
import 'package:my_grocery/src/services/utils_services.dart';

class OrderItemsController extends GetxController {
  final orderRepository = OrderRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();
  OrderModel order;
  bool isLoading = false;

  OrderItemsController(this.order);

  void setLoading(bool value) {
    isLoading = value;
  }

  Future<void> getOrderItems() async {
    setLoading(true);

    OrdersResult<List<CartItemModel>> result =
        await orderRepository.getOrderItems(
            orderId: order.id, token: authController.userModel.token!);

    setLoading(false);

    result.when(success: (items) {
      order.items = items;
      update();
    }, error: (message) {
      utilsServices.showToast(message: message, isError: true);
    });
  }
}
