import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/src/models/order_model.dart';
import 'package:my_grocery/src/pages/common_widget/payment_dialog.dart';
import 'package:my_grocery/src/pages/orders/components/order_item_widget.dart';
import 'package:my_grocery/src/pages/orders/components/order_status_widget.dart';
import 'package:my_grocery/src/pages/orders/controller/order_items_controller.dart';
import 'package:my_grocery/src/services/utils_services.dart';

class OrderTile extends StatelessWidget {
  OrderTile({
    super.key,
    required this.order,
  });

  final OrderModel order;
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: GetBuilder<OrderItemsController>(
              global: false,
              builder: (controller) {
                return ExpansionTile(
                  onExpansionChanged: (value) {
                    if (value && order.items.isEmpty) {
                      controller.getOrderItems();
                    }
                  },
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Pedido: ${order.id}'),
                      Text(
                        utilsServices.formatDateTime(order.createdDateTime!),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.black),
                      )
                    ],
                  ),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                  children: controller.isLoading
                      ? [
                          Container(
                            height: 80,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          )
                        ]
                      : [
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                //Orders Numbers
                                Expanded(
                                    flex: 3,
                                    child: SizedBox(
                                      height: 150,
                                      child: ListView(
                                        children: order.items.map((orderItem) {
                                          return OrderItemWidget(
                                              utilsServices: utilsServices,
                                              orderItem: orderItem);
                                        }).toList(),
                                      ),
                                    )),
                                //Divider
                                VerticalDivider(
                                  color: Colors.grey.shade300,
                                  thickness: 2,
                                  width: 8,
                                ),
                                //Order status
                                Expanded(
                                    flex: 2,
                                    child: OrderStatusWidget(
                                      status: order.status,
                                      isOverdue: order.overDudeDateTime
                                          .isBefore(DateTime.now()),
                                    ))
                              ],
                            ),
                          ),
                          //Total
                          Text.rich(
                            TextSpan(
                                style: const TextStyle(fontSize: 20),
                                children: [
                                  const TextSpan(
                                      text: 'Total ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: utilsServices.currency(order.total))
                                ]),
                          ),
                          //Buttom Payment
                          Visibility(
                            visible: order.status == 'pending_payment' &&
                                !order.isOverDue,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return PaymentDialog(order: order);
                                    });
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              icon: Image.asset(
                                'assets/app_images/pix.png',
                                height: 18,
                              ),
                              label: const Text('Ver QR Code pix'),
                            ),
                          )
                        ],
                );
              })),
    );
  }
}
