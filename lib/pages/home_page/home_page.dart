import 'package:flutter/material.dart';
import 'package:yogaflutter/services/auth.dart';
import 'package:yogaflutter/pages/home_page/form.dart';
import 'package:navigation_dot_bar/navigation_dot_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: BottomNavigationDotBar (
        activeColor: Colors.black, 
      items: <BottomNavigationDotBarItem>[
        BottomNavigationDotBarItem(icon: Icons.settings, onTap: () {}),
        BottomNavigationDotBarItem(icon: Icons.edit, onTap: () {}),
        BottomNavigationDotBarItem(icon: Icons.perm_identity , onTap: () {}),
      ]
      ),
      
        appBar: new AppBar(
          title: new Text("EasyYoga"),
          backgroundColor: Colors.indigo[400],
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
      
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(60.0),
          child: new MyCustomForm(),
        )
      ), 
    );
  }
}