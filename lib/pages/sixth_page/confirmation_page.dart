import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Cap prenotazione:'),
            Text('Tipo di Yoga: '),
            Text('Numero di Allievi:'),
            Text('Giorno:'),
            Text('Ora:'),
            Text('Istruttore:'),

          ],)
      )
    );
  }
}