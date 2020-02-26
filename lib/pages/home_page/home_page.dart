import 'package:flutter/material.dart';
import 'package:yogaflutter/services/auth.dart';
import 'package:yogaflutter/pages/home_page/pagine_menu.dart';
import 'package:yogaflutter/pages/home_page/form.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String currentProfilePic = "//inserire il proprio account";
  //String otherProfilePic = "https://yt3.ggpht.com/-2_2skU9e2Cw/AAAAAAAAAAI/AAAAAAAAAAA/6NpH9G8NWf4/s900-c-k-no-mo-rj-c0xffffff/photo.jpg";
  /* void switchAccounts() {
    String picBackup = currentProfilePic;
    this.setState(() {
      currentProfilePic = otherProfilePic;
      otherProfilePic = picBackup;
    });
  } */
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountEmail: new Text("//username"),
                accountName: new Text("//account name"),
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: new AssetImage('./pictures/yoga_logo.jpg'),
                        fit: BoxFit.fill)),
              ),
              new Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black54,
                    ],
                    stops: [0.5, 3.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.repeated,
                  ),
                ),
              ),
              new ListTile(
                title: new Text("Prenota una lezione"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                      new Page1("Prenota una lezione")));
                  }
              ),
              new ListTile(
                  title: new Text("Regala una lezione"),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                        new Page2("Regala una lezione")));
                  }),
              new Divider(),
            ],
          ),
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