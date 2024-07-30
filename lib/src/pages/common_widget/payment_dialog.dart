import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery/src/config/custom_colors.dart';
import 'package:my_grocery/src/models/order_model.dart';
import 'package:my_grocery/src/services/utils_services.dart';

class PaymentDialog extends StatelessWidget {
  PaymentDialog({super.key, required this.order});

  final OrderModel order;
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            //Button close
            Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                )),
            //Content
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Title
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Pagamneto por Pix ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  //Qr Code
                  Image.memory(
                    utilsServices.decodeQrCodeImage(order.qrCodeImage),
                    height: 200,
                    width: 200,
                  ),
                  //maturity
                  Text(
                    'Vencimento: ${utilsServices.formatDateTime(order.overDudeDateTime)}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  //total
                  Text(
                    'Total: ${utilsServices.currency(order.total)}',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  //Button copy and paste
                  OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          side: BorderSide(
                              width: 2,
                              color: CustomColors.customSwatchColor.shade300)),
                      onPressed: () {
                        FlutterClipboard.copy(order.copyAndPaste);
                        utilsServices.showToast(message: 'Codigo Copiado');
                      },
                      icon: const Icon(Icons.copy, size: 15),
                      label: const Text(
                        'Copiar codigo Pix',
                        style: TextStyle(fontSize: 13),
                      ))
                ],
              ),
            ),
          ],
        ));
  }
}
