import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/src/config/custom_colors.dart';
import 'package:my_grocery/src/pages/auth/controller/auth_controller.dart';
import 'package:my_grocery/src/pages/common_widget/custom_text_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../services/validators.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final cpfFormatter = MaskTextInputFormatter(
    mask: '## #####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final phoneFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w200),
                      ),
                    ),
                  ),
                  //Form
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 40),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(45),
                        )),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            icon: Icons.email_sharp,
                            label: 'Email',
                            keyBoardType: TextInputType.emailAddress,
                            validator: emailValidator,
                            onSaved: (value) {
                              authController.userModel.email = value;
                            },
                          ),
                          CustomTextField(
                            icon: Icons.lock,
                            label: 'Senha',
                            obscurePass: true,
                            validator: passValidator,
                            onSaved: (value) {
                              authController.userModel.pass = value;
                            },
                          ),
                          CustomTextField(
                            icon: Icons.person,
                            label: 'Nome',
                            keyBoardType: TextInputType.name,
                            validator: nameValidator,
                            onSaved: (value) {
                              authController.userModel.name = value;
                            },
                          ),
                          CustomTextField(
                            icon: Icons.phone,
                            label: 'Celular',
                            inputFormatter: [phoneFormatter],
                            keyBoardType: TextInputType.phone,
                            validator: phoneValidator,
                            onSaved: (value) {
                              authController.userModel.cellphone = value;
                            },
                          ),
                          CustomTextField(
                            icon: Icons.file_copy,
                            label: 'CPF',
                            inputFormatter: [cpfFormatter],
                            keyBoardType: TextInputType.number,
                            validator: cpfValidator,
                            onSaved: (value) {
                              authController.userModel.cpf = value;
                            },
                          ),
                          SizedBox(
                              height: 50,
                              child: Obx(() {
                                return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                    ),
                                    onPressed: authController.isLoading.value
                                        ? null
                                        : () {
                                            FocusScope.of(context).unfocus();
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState!.save();

                                              authController.signUp();
                                            }
                                          },
                                    child: authController.isLoading.value
                                        ? const CircularProgressIndicator()
                                        : const Text(
                                            'Cadastrar Usuario',
                                            style: TextStyle(fontSize: 18),
                                          ));
                              }))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
