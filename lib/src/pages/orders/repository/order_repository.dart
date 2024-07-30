import 'package:my_grocery/src/constants/endpoints.dart';
import 'package:my_grocery/src/models/cart_item_model.dart';
import 'package:my_grocery/src/models/order_model.dart';
import 'package:my_grocery/src/pages/orders/result/orders_result.dart';
import 'package:my_grocery/src/services/http_manager.dart';

class OrderRepository {
  final _httpManager = HttpManager();

  Future<OrdersResult<List<OrderModel>>> getAllOrders(
      {required String userId, required String token}) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.getAllOrders,
        method: HttpMethods.post,
        body: {
          'user': userId,
        },
        headers: {
          'X-Parse-Session-Token': token
        });

    if (result['result'] != null) {
      List<OrderModel> orders =
          List<Map<String, dynamic>>.from(result['result'])
              .map(OrderModel.fromJson)
              .toList();

      return OrdersResult<List<OrderModel>>.success(orders);
    } else {
      return OrdersResult.error('Não possivel recuperar os pedidos');
    }
  }

  Future<OrdersResult<List<CartItemModel>>> getOrderItems(
      {required String orderId, required String token}) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.getOrderItems,
        method: HttpMethods.post,
        body: {'orderId': orderId},
        headers: {'X-Parse-Session-Token': token});

    if (result['result'] != null) {
      List<CartItemModel> items =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();

      return OrdersResult.success(items);
    } else {
      return OrdersResult.error('Nãp foi possivel recuperar os itens');
    }
  }
}
