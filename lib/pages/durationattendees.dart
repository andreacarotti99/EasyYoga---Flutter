import 'package:flutter/material.dart';
import './image_banner.dart';
import 'package:yogaflutter/models/lesson.dart';



//questo riguarda solo la il primo dei tanti tipi di yoga che ci sono
class TypeBeginnerYoga extends StatelessWidget {

  final Lesson lesson;
  TypeBeginnerYoga({Key key, @required this.lesson}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(backgroundColor: Colors.indigo[400],),
      body: new Center(
        child: new ListView(
            children: <Widget>[
              //Primo Widget: Immagine
              ImageBanner("./pictures/yoga_logo.jpg"),
              //Secondo Widget: titolo tipo di Yoga
              Center(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Beginners Yoga',
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20),
                    ),
                    
                  )
                ),
              ),

              //Terzo Widget: Descrizione
              Center(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 10),
                    ),
                  )
                )
              ),

              //Titolo bottoni durata
              Center(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Numero di allievi',
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20),
                    ),
                    
                  )
                ),
              ),

              //Quarto Widget: Bottoni durata
              new Container(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    //build in a separated function
                    RaisedButton(
                      onPressed: (){},
                      child: Text(
                        "1",
                        style: TextStyle(
                          fontSize: 24.0,
                        )
                      )
                    ),
                    RaisedButton(
                      onPressed: (){},
                      child: Text(
                        "2",
                        style: TextStyle(
                          fontSize: 24.0,
                        )
                      )
                    ),
                    RaisedButton(
                      onPressed: (){},
                      child: Text(
                        "3",
                        style: TextStyle(
                          fontSize: 24.0,
                        )
                      )
                    ),
                    RaisedButton(
                      onPressed: (){},
                      child: Text(
                        "4",
                        style: TextStyle(
                          fontSize: 24.0,
                        )
                      )
                    ),
                  ],
                ),
              ),

            //Quinto Widget: numero di persone per la lezione

            //titolo durata
            Center(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Durata lezione',
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20),
                    ),
                )
              ),
            ),
            new Container(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                    //build in a separated function
                    RaisedButton(
                      onPressed: (){},
                      child: Text(
                        "1h",
                        style: TextStyle(
                        fontSize: 24.0,
                        )
                      )
                    ),

                    Bottone(testo: "2h")
                ]
              ),
            )
          ]
        )
      )
    );
  }
}

class Bottone extends StatelessWidget {
  const Bottone({this.testo});
  final String testo;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: (){},
        child: Text(
          testo,
          style: TextStyle(
          fontSize: 24.0,
          )
        )
    );
  }
}


//secondo tipo (...)

//terzo tipo(...)

//quarto(...)
