import 'package:yogaflutter/models/user.dart';
import 'package:yogaflutter/authenticate/authenticate.dart';
import 'package:yogaflutter/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return HomePage();
    }
    
  }
}