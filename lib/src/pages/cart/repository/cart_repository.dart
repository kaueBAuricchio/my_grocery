import 'package:my_grocery/src/constants/endpoints.dart';
import 'package:my_grocery/src/models/app_data.dart';
import 'package:my_grocery/src/models/cart_item_model.dart';
import 'package:my_grocery/src/models/order_model.dart';
import 'package:my_grocery/src/pages/cart/result/cart_result.dart';
import 'package:my_grocery/src/services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<CartResult<List<CartItemModel>>> getCartItems(
      {required String token, required String userId}) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.getCartItems,
        method: HttpMethods.post,
        headers: {
          'X-parse-Session-Token': token,
        },
        body: {
          user: userId,
        });

    if (result['result'] != null) {
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();

      return CartResult<List<CartItemModel>>.success(data);
    } else {
      return CartResult<List<CartItemModel>>.error(
          'Ocorreu um erro ao recuperar os itens do carrinho');
    }
  }

  Future<CartResult<String>> addItemToCart(
      {required String userId,
      required String token,
      required String productId,
      required int quantity}) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.addItemToCart,
        method: HttpMethods.post,
        body: {'user': userId, 'quantity': quantity, "productId": productId},
        headers: {'X-Parse-Session-token': token});

    if (result['result'] != null) {
      return CartResult.success(result['result']['id']);
    } else {
      return CartResult.error('Não foi possivel adicionar o item no carrinho');
    }
  }

  Future<bool> changeItemQuantity({
    required String token,
    required String carItemId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.changeItemQuantity,
        method: HttpMethods.post,
        body: {
          'cartItemId': carItemId,
          'quantity': quantity,
        },
        headers: {
          'X-Parse-Session-token': token
        });

    return result.isEmpty;
  }

  Future<CartResult<OrderModel>> checkoutCart(
      {required String token, required double total}) async {
    final result = await _httpManager
        .restRequest(url: Endpoints.checkout, method: HttpMethods.post, body: {
      'total': total,
    }, headers: {
      'X-Parse-Session-token': token
    });

    if (result['result'] != null) {
      final order = OrderModel.fromJson(result['result']);

      return CartResult<OrderModel>.success(order);
    } else {
      return CartResult.error('Nao foi possivel carregar o pedido');
    }
  }
}
