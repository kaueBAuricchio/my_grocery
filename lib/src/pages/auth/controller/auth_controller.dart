import 'package:get/get.dart';
import 'package:my_grocery/src/constants/storage_keys.dart';
import 'package:my_grocery/src/models/app_data.dart';
import 'package:my_grocery/src/models/user_model.dart';
import 'package:my_grocery/src/pages/auth/repository/auth_repository.dart';
import 'package:my_grocery/src/pages/auth/result/auth_result.dart';
import 'package:my_grocery/src/routes/app_pages.dart';
import 'package:my_grocery/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final AuthRepository _authRepository = AuthRepository();
  final UtilsServices utilsServices = UtilsServices();

  UserModel userModel = UserModel();

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    AuthResult result =
        await _authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    result.when(success: (user) {
      userModel = user;
      saveToken();
    }, error: (message) {
      utilsServices.showToast(message: message, isError: true);
    });
  }

  Future<void> signUp() async {
    isLoading.value = true;

    AuthResult result = await _authRepository.signUp(userModel);

    isLoading.value = false;

    result.when(success: (user) {
      userModel = user;
      saveToken();
    }, error: (message) {
      utilsServices.showToast(message: message, isError: true);
    });
  }

  Future<void> validateToken() async {
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);
    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }
    AuthResult result = await _authRepository.validateToken(token);

    result.when(success: (user) {
      userModel = user;

      saveToken();
    }, error: (message) {
      signOut();
    });
  }

  void saveToken() {
    utilsServices.saveLocalData(key: StorageKeys.token, data: user.token!);

    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> signOut() async {
    userModel = UserModel();

    await utilsServices.removeLocalData(key: StorageKeys.token);

    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  Future<void> resetPassword(String email) async {
    await _authRepository.resetPassword(email);
  }

  Future<void> changePassword(
      {required String currentPassword, required String newPassword}) async {
    isLoading.value = true;
    final result = await _authRepository.changePassword(
        token: userModel.token!,
        email: userModel.email!,
        currentPassword: currentPassword,
        newPassword: newPassword);

    isLoading.value = false;

    if (result) {
      utilsServices.showToast(message: 'A senha foi atualizada com sucesso');
      signOut();
    } else {
      utilsServices.showToast(
          message: 'A senha atual esta incorreta', isError: true);
    }
  }
}
