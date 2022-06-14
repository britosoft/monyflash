import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mf/src/page/client/product/list/list_product_controller.dart';

import '../../../../utilis/my_Colors.dart';

class ClientProductListPage extends StatefulWidget {
  ClientProductListPage({Key key}) : super(key: key);

  @override
  State<ClientProductListPage> createState() => _ClientProductListPageState();
}

class _ClientProductListPageState extends State<ClientProductListPage> {
  ClientProductsListController _con = new ClientProductsListController();

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
        title: Text('Products'),
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
                  CircleAvatar(
                    minRadius: 30.0,
                    maxRadius: 40.0,
                    child: ClipRRect(),
                    backgroundImage: _con.user?.image != null
                        ? NetworkImage(_con.user?.image)
                        : AssetImage('assets/imagenes/no-image.jpg'),
                  ),
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
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                ],
              )),
          ListTile(
            onTap: _con.goToUpdatePage,
            title: Text(
              'Editar perfil',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(
              Icons.edit_outlined,
              color: Colors.white,
            ),
          ),
          _con.user != null
              ? _con.user.roles.length > 1
                  ? ListTile(
                      onTap: _con.gouToRoles,
                      title: Text('Seleccionar rol',
                          style: TextStyle(color: Colors.white)),
                      trailing: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                      ),
                    )
                  : Container()
              : Container(),
          ListTile(
            onTap: _con.logout,
            title: Text(
              'Cerrar sesion',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(
              Icons.power_settings_new,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {}); // CTRL + S
  }
}
