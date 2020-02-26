import 'package:flutter/material.dart';

class Titolo extends StatelessWidget {
  const Titolo({this.titolo});
  final String titolo;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        
          padding: EdgeInsets.all(16.0),
            child: Text(
            titolo,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 20),
           ),
      )
    );
  }
}
