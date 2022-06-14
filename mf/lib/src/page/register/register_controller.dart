import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mf/src/page/models/Response_api.dart';
import 'package:mf/src/providers/user_provider.dart';
import 'package:mf/src/utilis/shared_preference.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../utilis/my_snackbar.dart';
import '.././models/user_models.dart';

class RegisterController {
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();
  ProgressDialog _progressDialog;

  PickedFile pickedFile;
  File imageFile;
  Function refresh;
  bool isEnable = true;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    usersProvider.init(context);
    _progressDialog = ProgressDialog(context: context);
    refresh();
  }

  void register() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    User user = new User(
      email: email,
      password: password,
    );
    _progressDialog.show(max: 100, msg: 'Espere...');
    Stream stream = await usersProvider.createWithImage(user, imageFile);
    stream.listen((res) {
      //ResponseApi responseApi = await usersProvider.create(user);

      // _progressDialog.close();
      // print('email, $email');
      // print('password, $password');
      //print('confirmPassword, $confirmPassword');

      //print('Respuesta object: ${responseApi}');
      _progressDialog.close();
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      print('RESPUESTA: ${responseApi.toJson()}');
      MySnackbar.show(context, responseApi.message);

      if (responseApi.success) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context, 'login');
        });
      }
    });

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

    //
  }

  Future selectImage(ImageSource imageSource) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    Navigator.pop(context);
    refresh();
  }

  void goToLoginPage() {
    Navigator.pushNamed(context, 'login');
  }

  void showAlertDialog() {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery);
        },
        child: Text('GALERIA'));

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera);
        },
        child: Text('Camara'));

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [galleryButton, cameraButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void back() {
    Navigator.pop(context);
  }
}
