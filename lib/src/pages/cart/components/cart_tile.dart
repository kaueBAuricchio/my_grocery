import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/src/config/custom_colors.dart';
import 'package:my_grocery/src/models/cart_item_model.dart';
import 'package:my_grocery/src/pages/cart/controller/cart_controller.dart';
import 'package:my_grocery/src/pages/common_widget/quantity_widget.dart';
import 'package:my_grocery/src/services/utils_services.dart';

class CartTile extends StatefulWidget {
  final CartItemModel cartItem;

  const CartTile({
    super.key,
    required this.cartItem,
  });

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final UtilsServices utilsServices = UtilsServices();
  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        //image
        leading: Image.network(
          widget.cartItem.item.imageUrl,
          height: 60,
          width: 60,
        ),
        //title
        title: Text(
          widget.cartItem.item.itemName,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        //Price
        subtitle: Text(utilsServices.currency(widget.cartItem.totalPrice()),
            style: TextStyle(
                color: CustomColors.customSwatchColor,
                fontWeight: FontWeight.bold)),
        //Quantity
        trailing: QuantityWidget(
          value: widget.cartItem.quantity,
          suffixText: widget.cartItem.item.unit,
          result: (quantity) {
            controller.changeItemQuantity(
                item: widget.cartItem, quantity: quantity);
          },
          isRemovable: true,
        ),
      ),
    );
  }
}
