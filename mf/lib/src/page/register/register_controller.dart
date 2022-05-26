import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mf/src/page/models/Response_api.dart';
import 'package:mf/src/providers/user_provider.dart';
import 'package:mf/src/utilis/shared_preference.dart';
import '../../utilis/my_snackbar.dart';
import '.././models/user_models.dart';

class RegisterController {
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();
  SharedPref _sharedPref = new SharedPref();

  bool isEnable = true;

  Future init(BuildContext context) async {
    this.context = context;
    usersProvider.init(context);
  }

  void register() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    User user = new User(
      email: email,
      password: password,
    );

    ResponseApi responseApi = await usersProvider.create(user);

    print('email, $email');
    print('password, $password');
    print('confirmPassword, $confirmPassword');

    print('RESPUESTA: ${responseApi.toJson()}');
    print('Respuesta object: ${responseApi}');

    MySnackbar.show(context, responseApi.message);

    if (responseApi.success) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, 'login');
      });
    }

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }
    if (password != confirmPassword) {
      MySnackbar.show(context, 'Las contraseñas no coinciden');
      return;
    }

    if (password.length < 4) {
      MySnackbar.show(
          context, 'Las contraseña debe tener al menos 4 caracteres');
      return;
    }
  }

  void goToLoginPage() {
    Navigator.pushNamed(context, 'login');
  }
}
