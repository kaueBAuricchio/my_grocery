import 'package:get/get.dart';
import 'package:my_grocery/src/pages/auth/view/sign_in_screen.dart';
import 'package:my_grocery/src/pages/auth/view/sign_up_screen.dart';
import 'package:my_grocery/src/pages/base/base_screen.dart';
import 'package:my_grocery/src/pages/base/binding/base_binding.dart';
import 'package:my_grocery/src/pages/cart/binding/cart_binding.dart';
import 'package:my_grocery/src/pages/home/binding/home_binding.dart';
import 'package:my_grocery/src/pages/orders/bindings/orders_binding.dart';
import 'package:my_grocery/src/pages/product/product_screen.dart';
import 'package:my_grocery/src/pages/splash/splash_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(name: PagesRoutes.splashRoute, page: () => const SplashScreen()),
    GetPage(name: PagesRoutes.signInRoute, page: () => SignInScreen()),
    GetPage(name: PagesRoutes.signUpRoute, page: () => SignUpScreen()),
    GetPage(
        name: PagesRoutes.baseRoute,
        page: () => const BaseScreen(),
        bindings: [
          HomeBinding(),
          BaseBinding(),
          CartBinding(),
          OrdersBinding()
        ]),
    GetPage(name: PagesRoutes.productRoute, page: () => ProductScreen())
  ];
}

abstract class PagesRoutes {
  static const String splashRoute = '/product';
  static const String signInRoute = '/signIn';
  static const String signUpRoute = '/signUp';
  static const String productRoute = '/signUp';
  static const String baseRoute = '/';
}
