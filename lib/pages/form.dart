import 'package:flutter/material.dart';
import './pageyogatypes.dart';
import 'package:yogaflutter/models/lesson.dart';

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    //passo il parametro newlesson dopo aver importato la classe lesson cosi posso trasportarlo tra una route e l'altra
    final newLesson = new Lesson(null, null, null, null, null);


    // Build a Form widget using the _formKey created above.
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
              return null;
            },
          ),
          RaisedButton(
            onPressed: () {
              // Validate returns true if the form is valid, otherwise false.
              if (_formKey.currentState.validate()) {
              // If the form is valid, display a snackbar. In the real world,
              // you'd often call a server or save the information in a database.
                Scaffold
                  .of(context)
                  .showSnackBar(SnackBar(content: Text('Verificando il CAP...')));
                
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) =>
                      PageYogaTypes(lesson: newLesson,)));
              }
            },
            child: Text('Verifica CAP'),
          )
        ]
     )
    );
  }
}

