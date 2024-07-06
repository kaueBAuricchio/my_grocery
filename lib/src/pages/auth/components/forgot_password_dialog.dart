import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/src/pages/auth/controller/auth_controller.dart';
import 'package:my_grocery/src/pages/common_widget/custom_text_field.dart';
import 'package:my_grocery/src/services/validators.dart';

class ForgotPasswordDialog extends StatelessWidget {
  final emailController = TextEditingController();

  ForgotPasswordDialog({required String email, super.key}) {
    emailController.text = email;
  }

  final formFieldKey = GlobalKey<FormFieldState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          //Content
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                //Title
                const Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 20,
                  ),
                  child: Text(
                    'Digite o seu email para recuperar seu senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                ),
                //TextField Email
                CustomTextField(
                  formFieldKey: formFieldKey,
                  controller: emailController,
                  icon: Icons.email,
                  label: 'Email',
                  validator: emailValidator,
                ),
                //Button Confirm
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: const BorderSide(width: 2, color: Colors.purple),
                    ),
                    onPressed: () {
                      if (formFieldKey.currentState!.validate()) {
                        authController.resetPassword(emailController.text);
                        Get.back(result: true);
                      }
                    },
                    child: const Text(
                      'Recuperar',
                    ))
              ],
            ),
          ),
          Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              )),
        ],
      ),
    );
  }
}
