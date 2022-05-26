import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mf/src/page/models/rol.dart';
import 'package:mf/src/page/roles/roles_controller.dart';
import 'package:mf/src/utilis/my_Colors.dart';
import 'package:transparent_image/transparent_image.dart';

class Roles extends StatefulWidget {
  Roles({Key key}) : super(key: key);

  @override
  State<Roles> createState() => _RolesState();
}

class _RolesState extends State<Roles> {
  RolesController _con = new RolesController();

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
      appBar: AppBar(
          title: Text('Selecione un Rol'),
          backgroundColor: MyColors.secundaryColor),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
        child: ListView(
            children: _con.user != null
                ? _con.user.roles.map((Rol rol) {
                    return _cardRol(rol);
                  }).toList()
                : []),
      ),
    );
  }

  Widget _cardRol(Rol rol) {
    return GestureDetector(
      onTap: () {
        _con.goToPage(rol.route);
        print(rol.image);
      },
      child: Column(
        children: [
          Container(
            height: 100,

            child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage, image: rol.image),

            //Image.network(rol.image),
          ),
          SizedBox(height: 15),
          Text(
            rol.name ?? '',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
