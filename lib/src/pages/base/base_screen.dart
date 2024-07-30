import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/src/config/custom_colors.dart';
import 'package:my_grocery/src/pages/base/controller/base_controller.dart';
import 'package:my_grocery/src/pages/cart/view/cart_tab.dart';
import 'package:my_grocery/src/pages/home/view/home_tab.dart';
import 'package:my_grocery/src/pages/profile/profile_tab.dart';

import '../orders/view/orders_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final baseController = Get.find<BaseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: baseController.pageController,
        children: [
          const HomeTab(),
          const CartTab(),
          const OrdersTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: CustomColors.customSwatchColor,
            currentIndex: baseController.currentIndex,
            onTap: (index) {
              setState(() {
                baseController.navigatePageView(index);
              });
            },
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: 'Carrinho',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt_outlined), label: 'Pedidos'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outlined), label: 'Pedidos'),
            ],
          )),
    );
  }
}
