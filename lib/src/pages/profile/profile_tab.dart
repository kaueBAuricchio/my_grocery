import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/src/config/custom_colors.dart';
import 'package:my_grocery/src/pages/auth/controller/auth_controller.dart';
import 'package:my_grocery/src/pages/common_widget/custom_text_field.dart';
import 'package:my_grocery/src/services/validators.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do usuario'),
        actions: [
          IconButton(
              onPressed: () {
                authController.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          //Email
          CustomTextField(
            icon: Icons.email,
            label: 'Email',
            initialValue: authController.userModel.email,
            readOnly: true,
          ),
          //Name
          CustomTextField(
            icon: Icons.person,
            label: 'Nome',
            initialValue: authController.userModel.name,
            readOnly: true,
          ),
          //Phone
          CustomTextField(
            icon: Icons.phone,
            label: 'Celular',
            initialValue: authController.userModel.cellphone,
            readOnly: true,
          ),
          //CPF
          CustomTextField(
            icon: Icons.file_copy,
            label: 'CPF',
            obscurePass: true,
            initialValue: authController.userModel.cpf,
            readOnly: true,
          ),
          //Buttom refresh password
          SizedBox(
            height: 50,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: CustomColors.customSwatchColor),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () {
                  updatePassword();
                },
                child: const Text("Atulizar senha ")),
          )
        ],
      ),
    );
  }

  //Dialog new password
  Future<bool?> updatePassword() {
    final newPasswordController = TextEditingController();
    final currentPasswordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //Title
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            'Atualizar senha',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Current Password
                        CustomTextField(
                          controller: currentPasswordController,
                          icon: Icons.lock,
                          label: 'Senha atual',
                          initialValue: authController.userModel.pass,
                          obscurePass: true,
                          validator: passValidator,
                        ),
                        //New Password
                        CustomTextField(
                          controller: newPasswordController,
                          icon: Icons.lock_outline,
                          label: 'Nova senha',
                          obscurePass: true,
                          validator: passValidator,
                        ),
                        //Confirm Password
                        CustomTextField(
                          icon: Icons.lock_outline,
                          label: 'Confirmar senha ',
                          obscurePass: true,
                          validator: (password) {
                            final result = passValidator(password);

                            if (result != null) {
                              return result;
                            }

                            if (password != newPasswordController.text) {
                              return 'As senhas não são equivalentes';
                            }

                            return null;
                          },
                        ),
                        //Button change password
                        SizedBox(
                          height: 45,
                          child: Obx(() => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        authController.changePassword(
                                            currentPassword:
                                                currentPasswordController.text,
                                            newPassword:
                                                newPasswordController.text);
                                      }
                                    },
                              child: authController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : const Text('Atualizar senha'))),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 5,
                    right: 5,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close)))
              ],
            ),
          );
        });
  }
}
