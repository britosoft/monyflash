import 'package:flutter/material.dart';
import 'package:mf/src/page/boutique/orders/list/boutique_orders_list_page.dart';
import 'package:mf/src/page/client/product/list/list_product.dart';
import 'package:mf/src/page/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:mf/src/page/login/login_page.dart';
import 'package:mf/src/page/models/rol.dart';
import 'package:mf/src/page/register/register_page.dart';
import 'package:mf/src/page/roles/roles.dart';
import 'package:mf/src/utilis/my_Colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mony Flash',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
        'client/products/list': (BuildContext context) =>
            ClientProductListPage(),
        'boutique/orders/list': (BuildContext context) =>
            BoutiqueOdersListPage(),
        'delivery/orders/list': (BuildContext context) =>
            DeliveryOdersListPage(),
        'roles': (BuildContext context) => Roles()
      },
    );
  }
}
