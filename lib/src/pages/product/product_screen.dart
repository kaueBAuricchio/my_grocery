import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/src/config/custom_colors.dart';
import 'package:my_grocery/src/models/item_model.dart';
import 'package:my_grocery/src/pages/base/controller/base_controller.dart';
import 'package:my_grocery/src/pages/cart/controller/cart_controller.dart';
import 'package:my_grocery/src/pages/common_widget/quantity_widget.dart';
import 'package:my_grocery/src/services/utils_services.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({super.key});

  final ItemModel item = Get.arguments;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  UtilsServices utilsServices = UtilsServices();

  int itemQuantity = 1;

  final baseController = Get.find<BaseController>();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: Hero(
                      tag: widget.item.imageUrl,
                      child: Image.asset(widget.item.imageUrl))),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                      color: CustomColors.customSwatchColor,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20)),
                      boxShadow: const [
                        BoxShadow(color: Colors.white, offset: Offset(0, 2))
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //Name - quantity
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.item.itemName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          QuantityWidget(
                            value: itemQuantity,
                            suffixText: widget.item.unit,
                            result: (quantity) {
                              setState(() {
                                itemQuantity = quantity;
                              });
                            },
                          ),
                        ],
                      ),
                      //Price
                      Text(
                        utilsServices.currency(widget.item.price),
                        style: const TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      //Description
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SingleChildScrollView(
                            child: Text(
                              widget.item.description!,
                              style: const TextStyle(
                                  height: 1.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      //Button add cart
                      SizedBox(
                        height: 55,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: () {
                            //Close
                            Get.back();

                            cartController.addItemToCart(
                                itemModel: widget.item, quantity: itemQuantity);

                            baseController
                                .navigatePageView(NavigationTabs.cart);
                          },
                          label: Text(
                            "Adicionar no carrinho",
                            style: TextStyle(
                                color: CustomColors.customSwatchColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          icon: Icon(Icons.shopping_cart_outlined,
                              color: CustomColors.customSwatchColor),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          //Arrow Back
          Positioned(
            top: 10,
            left: 10,
            child: SafeArea(
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: CustomColors.customSwatchColor,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
