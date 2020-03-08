import 'package:flutter/material.dart';
import 'package:yogaflutter/services/auth.dart';
import 'package:yogaflutter/pages/home_page/form.dart';
import 'package:yogaflutter/pages/home_page/settings.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      /*bottomNavigationBar: BottomNavigationDotBar (
        activeColor: Colors.black, 
      items: <BottomNavigationDotBarItem>[
        BottomNavigationDotBarItem(icon: Icons.settings, onTap: () => Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context) => SettingsPage()))),
        BottomNavigationDotBarItem(icon: Icons.edit, onTap: () {}),
        BottomNavigationDotBarItem(icon: Icons.perm_identity , onTap: () {}),
      ]
      ),*/
      bottomNavigationBar: TitledBottomNavigationBar(
        reverse: true,
        inactiveStripColor: Colors.grey,
        indicatorColor: Colors.black,
        currentIndex: 1, // Use this to update the Bar giving a position
        onTap: (index){
          print("Selected Index: $index");
          if(index == 2) {
            Navigator.of(context).push(
              new MaterialPageRoute(builder: (BuildContext context) => SettingsPage()));
          }
        },
        items: [
            TitledNavigationBarItem(title: 'Profile', icon: Icons.perm_identity),
            TitledNavigationBarItem(title: 'Book', icon: Icons.edit),
            TitledNavigationBarItem(title: 'Settings', icon: Icons.settings),  
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