import 'package:my_grocery/src/constants/endpoints.dart';
import 'package:my_grocery/src/models/user_model.dart';
import 'package:my_grocery/src/pages/auth/result/auth_errors.dart'
    as auth_errors;
import 'package:my_grocery/src/pages/auth/result/auth_result.dart';
import 'package:my_grocery/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  AuthResult handleUserOrError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);

      return AuthResult.success(user);
    } else {
      return AuthResult.error(auth_errors.authErrorsString(result['error']));
    }
  }

  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.validToken,
        method: HttpMethods.post,
        headers: {'X-Parse-Session-Token': token});

    return handleUserOrError(result);
  }

  Future<AuthResult> signIn(
      {required String email, required String password}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signIn,
      method: HttpMethods.post,
      body: {"email": email, "password": password},
    );

    return handleUserOrError(result);
  }

  Future<AuthResult> signUp(UserModel user) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.signUp, method: HttpMethods.post, body: user.toJson());

    return handleUserOrError(result);
  }

  Future<void> resetPassword(String email) async {
    await _httpManager.restRequest(
        url: Endpoints.resetPassword,
        method: HttpMethods.post,
        body: {'email': email});
  }

  Future<bool> changePassword(
      {required String token,
      required String email,
      required String currentPassword,
      required String newPassword}) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.changePassword,
        method: HttpMethods.post,
        headers: {
          'X-Parse-Session-Token': token
        },
        body: {
          'email': email,
          'currentPassword': currentPassword,
          'newPassword': newPassword
        });

    return result['error'] == null;
  }
}
