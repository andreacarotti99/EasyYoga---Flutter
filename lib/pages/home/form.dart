import 'package:flutter/material.dart';
import 'package:yogaflutter/pages/typesofyogas/typesofyogas.dart';
import 'package:yogaflutter/models/lesson.dart';

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final Lesson lesson = new Lesson(null, null, null, null, null, null, null);
  
  @override
  Widget build(BuildContext context) {
    
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Inserisci il tuo CAP'),
            style: new TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value.isEmpty) {
                return 'Perfavore inserisci un CAP valido';
              }
              else{
                print('$value');
                lesson.cap = value;
              }
              return null;
            }
          ),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) { // Validate returns true if the form is valid, otherwise false.
                Scaffold
                  .of(context)
                  .showSnackBar(SnackBar(content: Text('Verificando il CAP...')));
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => PageYogaTypes()));
              }
            },
            child: Text('Verifica CAP'),
          )
        ]
     )
    );
  }
}

