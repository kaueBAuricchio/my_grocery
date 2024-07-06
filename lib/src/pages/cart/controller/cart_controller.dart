import 'package:get/get.dart';
import 'package:my_grocery/src/models/cart_item_model.dart';
import 'package:my_grocery/src/models/item_model.dart';
import 'package:my_grocery/src/pages/auth/controller/auth_controller.dart';
import 'package:my_grocery/src/pages/cart/repository/cart_repository.dart';
import 'package:my_grocery/src/pages/cart/result/cart_result.dart';
import 'package:my_grocery/src/services/utils_services.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();

    getCarItems();
  }

  double cartPriceTotal() {
    double total = 0;

    for (final item in cartItems) {
      total += item.totalPrice();
    }

    return total;
  }

  Future<void> getCarItems() async {
    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
            token: authController.userModel.token!,
            userId: authController.userModel.id!);

    result.when(success: (data) {
      cartItems = data;
      update();
    }, error: (message) {
      utilsServices.showToast(message: message, isError: true);
    });
  }

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((itemList) => itemList.item.id == item.id);
  }

  Future<void> addItemToCart(
      {required ItemModel itemModel, int quantity = 1}) async {
    int itemIndex = getItemIndex(itemModel);

    if (itemIndex >= 0) {
      final product = cartItems[itemIndex];
      await changeItemQuantity(
          item: product, quantity: (product.quantity + quantity));
    } else {
      final CartResult<String> result = await cartRepository.addItemToCart(
          userId: authController.userModel.id!,
          token: authController.userModel.token!,
          productId: itemModel.id,
          quantity: quantity);

      result.when(success: (itemId) {
        cartItems.add(
            CartItemModel(item: itemModel, id: itemId, quantity: quantity));
      }, error: (message) {
        utilsServices.showToast(message: message, isError: true);
      });

      cartItems.add(
          CartItemModel(item: itemModel, id: itemModel.id, quantity: quantity));
    }
    update();
  }

  Future<bool> changeItemQuantity(
      {required CartItemModel item, required int quantity}) async {
    final result = await cartRepository.changeItemQuantity(
        token: authController.userModel.token!,
        carItemId: item.id,
        quantity: quantity);

    if (result) {
      if (quantity == 0) {
        cartItems.removeWhere((cartItem) => cartItem.id == item.id);
      } else {
        cartItems.firstWhere((cartItem) => cartItem.id == item.id).quantity ==
            quantity;
      }
      update();
    } else {
      utilsServices.showToast(
          message: 'Ocorreu um erro ao alterar a quantidade do produto',
          isError: true);
    }
    return result;
  }
}
