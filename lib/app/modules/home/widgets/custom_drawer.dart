import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
                Center(
                  child: Text(
                    "Vakup",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),
          ListTile(
            leading: Icon(Icons.read_more),
            title: Text('Leer datos'),
            onTap: () {}

          ),
          ListTile(
            leading: Icon(Icons.pets),
            title: Text('Registrar animal'),
            onTap: () {}

          ),
          ListTile(
            leading: Icon(Icons.list_alt),
            title: Text('Lista movimientos'),
            onTap: () {

            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Lista animales'),
            onTap: () {

            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Grabar datos'),
            onTap: () {

            },
          ),
          ListTile(
            leading: Icon(Icons.bluetooth),
            title: Text('Conexion BT'),
            onTap: () {

            },
          ),
          ListTile(
            leading: Icon(Icons.picture_as_pdf),
            title: Text('Exportar Datos'),
            onTap: () {

            },
          ),
          ListTile(
            leading: Icon(Icons.recent_actors_rounded),
            title: Text('Acerca de'),
            onTap: () {

            },
          ),
        ],
      ),
    );
  }
}