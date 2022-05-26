import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mf/src/page/client/product/list/list_product_controller.dart';
import 'package:mf/src/page/delivery/orders/list/delivery_controller.dart';

import '../../../../utilis/my_Colors.dart';

class DeliveryOdersListPage extends StatefulWidget {
  DeliveryOdersListPage({Key key}) : super(key: key);

  @override
  State<DeliveryOdersListPage> createState() => _DeliveryOdersListPageState();
}

class _DeliveryOdersListPageState extends State<DeliveryOdersListPage> {
  DeliveryOdersListPageController _con = new DeliveryOdersListPageController();

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
      key: _con.key,
      appBar: AppBar(
        title: Text('Delivery'),
        backgroundColor: MyColors.secundaryColor,
        leading: _menuDrawer(),
      ),
      drawer: _drawer(),
    );
  }

  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset('assets/imagenes/menu.png', width: 20, height: 20),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      backgroundColor: MyColors.primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: MyColors.secundaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.email ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.phone ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 10),
                    child: FadeInImage(
                      image: _con.user?.image != null
                          ? NetworkImage(_con.user?.image)
                          : AssetImage('assets/imagenes/no-image.jpg'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/imagenes/no-image.jpg'),
                    ),
                  )
                ],
              )),
          ListTile(
            //onTap: _con.goToUpdatePage,
            title: Text(
              'Editar perfil',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
            trailing: Icon(Icons.edit_outlined),
          ),
          ListTile(
            // onTap: _con.goToOrdersList,
            title: Text(
              'Mis pedidos',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
            trailing: Icon(Icons.shopping_cart_outlined),
          ),
          Container(),
          ListTile(
            onTap: _con.logout,
            title: Text(
              'Cerrar sesion',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
            trailing: Icon(Icons.power_settings_new),
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {}); // CTRL + S
  }
}
