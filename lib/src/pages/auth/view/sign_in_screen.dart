import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/src/config/custom_colors.dart';
import 'package:my_grocery/src/pages/auth/components/forgot_password_dialog.dart';
import 'package:my_grocery/src/pages/auth/controller/auth_controller.dart';
import 'package:my_grocery/src/routes/app_pages.dart';
import 'package:my_grocery/src/services/utils_services.dart';
import '../../../services/validators.dart';
import '../../common_widget/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //App Name
                    Text.rich(
                      TextSpan(style: const TextStyle(fontSize: 40), children: [
                        const TextSpan(
                            text: 'Grocery',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300)),
                        TextSpan(
                          text: 'store',
                          style: TextStyle(
                              color: CustomColors.customContrastColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(fontSize: 25),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          pause: Duration.zero,
                          animatedTexts: [
                            FadeAnimatedText('Frutas'),
                            FadeAnimatedText('Verduras'),
                            FadeAnimatedText('Legumes'),
                            FadeAnimatedText('Carnes'),
                            FadeAnimatedText('Cereais'),
                            FadeAnimatedText('Laticinios'),
                            FadeAnimatedText('Guloseimas'),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //Form
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 32,
                  horizontal: 40,
                ),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(45))),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //TextField Email
                      CustomTextField(
                        controller: emailController,
                        icon: Icons.email_sharp,
                        label: 'Email',
                        keyBoardType: TextInputType.emailAddress,
                        validator: emailValidator,
                      ),
                      //TextField Password
                      CustomTextField(
                          controller: passController,
                          icon: Icons.lock,
                          label: 'Senha',
                          obscurePass: true,
                          validator: passValidator),
                      //Button Entry
                      SizedBox(
                        height: 50,
                        child: GetX<AuthController>(
                          builder: (authController) {
                            return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                ),
                                onPressed: authController.isLoading.value
                                    ? null
                                    : () {
                                        FocusScope.of(context).unfocus();
                                        if (_formKey.currentState!.validate()) {
                                          String email = emailController.text;
                                          String password = passController.text;
                                          authController.signIn(
                                              email: email, password: password);
                                          Get.offNamed(PagesRoutes.baseRoute);
                                        } else {
                                          print('Campos não validos');
                                        }
                                      },
                                child: authController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        'Entrar',
                                        style: TextStyle(fontSize: 18),
                                      ));
                          },
                        ),
                      ),
                      //Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () async {
                            final bool? result = await showDialog(
                                context: context,
                                builder: (_) {
                                  return ForgotPasswordDialog(
                                      email: emailController.text);
                                });
                            if (result ?? false) {
                              return utilsServices.showToast(
                                  message:
                                      'Um link foi de recuepração foi enviado para seu email');
                            }
                          },
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                                color: CustomColors.customContrastColor),
                          ),
                        ),
                      ),
                      //Divider
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: CustomColors.customSwatchColor,
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text('Ou'),
                            ),
                            Expanded(
                              child: Divider(
                                color: CustomColors.customSwatchColor,
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Button Create User
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () {
                            Get.offNamed(PagesRoutes.signUpRoute);
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            side: BorderSide(
                                width: 2,
                                color: CustomColors.customSwatchColor),
                          ),
                          child: const Text(
                            'Criar conta',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
