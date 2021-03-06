import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart';
import 'package:mf/src/page/register/register_controller.dart';

import '../../utilis/my_Colors.dart';
import '../register/register_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController _con = new RegisterController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: MyColors.primaryColor,
      ),
      child: SingleChildScrollView(
          child: Column(
        children: [
          _logo(),
          _imageUser(),
          _textRegister(),
          _textFieldEmailRegister(),
          _textFieldPasswordRegister(),
          _textFieldPasswordRepit(),
          _buttonRegister(),
          _textHaveAccount(),
        ],
      )),
    ));
  }

  Widget _logo() {
    return Container(
      child: Image.asset(
        'assets/imagenes/semaforo.png',
        fit: BoxFit.fill,
        width: 250,
        height: 250,
      ),
    );
  }

  Widget _textRegister() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: Text(
        'Register',
        style: TextStyle(
            color: MyColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontFamily: 'NimbusSans'),
      ),
    );
  }

  Widget _textFieldPasswordRegister() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.whiteColor, borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.passwordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Contrase??a',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColor),
            prefixIcon: Icon(
              Icons.lock,
              color: MyColors.secundaryColor,
            )),
      ),
    );
  }

  Widget _textFieldPasswordRepit() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.whiteColor, borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Repita la Contrase??a',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColor),
            prefixIcon: Icon(
              Icons.lock,
              color: MyColors.secundaryColor,
            )),
      ),
    );
  }

  Widget _textFieldEmailRegister() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.whiteColor, borderRadius: BorderRadius.circular(30)),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: _con.emailController,
        decoration: InputDecoration(
            hintText: 'Email',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColor),
            prefixIcon: Icon(
              Icons.mail,
              color: MyColors.secundaryColor,
            )),
      ),
    );
  }

  Widget _textHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '??Ya tienes cuenta?',
          style: TextStyle(color: MyColors.secundaryColor, fontSize: 17),
        ),
        SizedBox(width: 7),
        GestureDetector(
          onTap: _con.goToLoginPage,
          child: Text(
            'Login',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.whiteColor,
                fontSize: 17),
          ),
        ),
      ],
    );
  }

  Widget _buttonRegister() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.isEnable ? _con.register : null,
        child: Text(
          'Register',
          style: TextStyle(color: MyColors.whiteColor),
        ),
        style: ElevatedButton.styleFrom(
            primary: MyColors.secundaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  Widget _imageUser() {
    return GestureDetector(
      onTap: _con.showAlertDialog,
      child: CircleAvatar(
        backgroundImage: _con.imageFile != null
            ? FileImage(_con.imageFile)
            : AssetImage('assets/imagenes/mf.jpg'),
        radius: 60,
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
