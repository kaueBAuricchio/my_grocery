import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/src/config/custom_colors.dart';
import 'package:my_grocery/src/pages/auth/controller/auth_controller.dart';
import 'package:my_grocery/src/pages/common_widget/custom_text_field.dart';
import 'package:my_grocery/src/models/app_data.dart' as appData;

class ProfileTab extends StatefulWidget {
  ProfileTab({Key? key}) : super(key: key);

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
            initialValue: appData.user.email,
            readOnly: true,
          ),
          //Name
          CustomTextField(
            icon: Icons.person,
            label: 'Nome',
            initialValue: appData.user.name,
            readOnly: true,
          ),
          //Phone
          CustomTextField(
            icon: Icons.phone,
            label: 'Celular',
            initialValue: appData.user.cellphone,
            readOnly: true,
          ),
          //CPF
          CustomTextField(
            icon: Icons.file_copy,
            label: 'CPF',
            obscurePass: true,
            initialValue: appData.user.cpf,
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
                        icon: Icons.lock,
                        label: 'Senha atual',
                        initialValue: appData.user.pass,
                        obscurePass: true,
                      ),
                      //New Password
                      const CustomTextField(
                        icon: Icons.lock_outline,
                        label: 'Nova senha',
                        obscurePass: true,
                      ),
                      //Confirm Password
                      const CustomTextField(
                        icon: Icons.lock_outline,
                        label: 'Confirmar senha ',
                        obscurePass: true,
                      ),
                      //Button change password
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {},
                            child: const Text('Atualizar senha')),
                      )
                    ],
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
