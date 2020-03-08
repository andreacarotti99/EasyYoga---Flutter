import 'package:flutter/material.dart';
import 'package:yogaflutter/pages/third_page/image_banner.dart';
import 'package:yogaflutter/models/lesson.dart';
import 'package:yogaflutter/pages/fourth_page/pick_date_page.dart';
import 'package:yogaflutter/pages/third_page/titolo.dart';
import 'dart:convert';


class TypeBeginnerYoga extends StatefulWidget {
  final Lesson lesson;
  TypeBeginnerYoga({Key key, @required this.lesson,}) : super(key: key);
  
  @override
  _TypeBeginnerYoga createState() => _TypeBeginnerYoga(lesson: lesson);
}

//questo riguarda solo la il primo dei tanti tipi di yoga che ci sono
class _TypeBeginnerYoga extends State<TypeBeginnerYoga> {
  Lesson lesson;
  _TypeBeginnerYoga({this.lesson}); 
  List<bool> isSelected1;
  List<bool> isSelected2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSelected1 = [
      true,
      false,
      false,
    ];
    isSelected2 = [
      true,
      false,
      false,
    ];
  }

  @override
  Widget build(BuildContext context) {

    //Future<Scaffold> createPage() async {
      //List<Widget> items = new List<Widget>();
      //String dataString =
        //  await DefaultAssetBundle.of(context).loadString("./load_json/instructors.json");
      //List<dynamic> dataJSON = jsonDecode(dataString);
      
      //dataJSON.forEach((object) {
        //if(object["typeTitle"] == /*titolo della casella cliccata*/ ) {
          //display the image
        //}
      //});

      





    return new Scaffold(
      appBar: new AppBar(backgroundColor: Colors.indigo[400],),
      body: new Center(
        child: new ListView( 
          children: <Widget>[
          //Primo Widget: Immagine
          ImageBanner("./pictures/yoga_logo.jpg"),
          //Secondo Widget: titolo tipo di Yoga
          Titolo(titolo: 'Beginners Yoga'),
          //Terzo Widget: Descrizione
          Center(
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum.',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 8),
                ),
              )
            )
          ),

          //Titolo bottoni durata
          Titolo(titolo: 'Numero di allievi'),

          //Quarto Widget: Bottoni durata
          new Container(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
              //build in a separated function
              ToggleButtons(
                children: <Widget>[
                  Text('1'),
                  Text('2'),
                  Text('3'),
                ],
                isSelected: isSelected1,
                onPressed: (index) {
                  setState(() {
                    for (var i=0; i<isSelected1.length; i++) {
                      if (i == index) {
                        lesson.attendees = i.toString();
                        isSelected1[i] = true;
                      } else {
                          isSelected1[i] = false;
                      }
                    }
                  });
                 },
              )
              ]
            ),
         ),

            //titolo durata
          Titolo(titolo: 'Durata Lezione'),
          new Container(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                    //build in a separated function
                ToggleButtons(
                  children: <Widget>[
                    Text('1h'),
                    Text('2h'),
                    Text('3h'),
                  ],
                      isSelected: isSelected2,
                      onPressed: (index) {
                        
                        setState(() {
                          for (var i=0; i<isSelected2.length; i++) {
                            if (i == index) {
                              isSelected2[i] = true;
                              lesson.duration = i.toString();
                            } else {
                              isSelected2[i] = false;
                            }
                          }
                        });
                      },
                )
                ]
            ),
          ),

            Center(
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) =>
                      PagePickDate(lesson: lesson,)));
                },
                child: Text(
                  'Prosegui',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 16)
                  )
              )
            )

          ]
        )
      )
    );
  }
  //}
}