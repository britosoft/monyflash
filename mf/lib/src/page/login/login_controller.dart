import 'package:flutter/material.dart';
import 'package:mf/src/page/models/Response_api.dart';
import 'package:mf/src/providers/user_provider.dart';
import 'package:mf/src/utilis/my_snackbar.dart';
import 'package:mf/src/page/models/user_models.dart';
import 'package:mf/src/utilis/shared_preference.dart';

class LoginController {
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);

    User user = User.fromJson(await _sharedPref.read('user') ?? {});

    print('Usuario: ${user.toJson()}');

    if (user?.sessionToken != null) {
      if (user.roles.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, 'client/products/list', (route) => false);
      }
      Navigator.pushNamedAndRemoveUntil(
          context, 'client/products/list', (route) => false);
    }
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context, 'register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi responseApi = await usersProvider.login(email, password);

    if (responseApi.success) {
      User user = User.fromJson(responseApi.data);
      _sharedPref.save('user', user.toJson());

      if (user.roles.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, 'client/products/list', (route) => false);
      }
    } else {
      MySnackbar.show(context, responseApi.message);
    }

    print('Respuesta object: ${responseApi}');
    print('Respuesta: ${responseApi.toJson()}');
  }
}
