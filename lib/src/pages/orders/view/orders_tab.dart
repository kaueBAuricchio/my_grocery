import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:my_grocery/src/pages/orders/controller/orders_controller.dart';
import 'package:my_grocery/src/pages/orders/view/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: GetBuilder<OrdersController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () => controller.getAllOrders(),
            child: ListView.separated(
                padding: const EdgeInsets.all(16),
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder: (_, index) => const SizedBox(height: 10),
                itemBuilder: (_, index) => OrderTile(
                      order: controller.allOrders[index],
                    ),
                itemCount: controller.allOrders.length),
          );
        },
      ),
    );
  }
}
