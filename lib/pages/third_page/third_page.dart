import 'package:flutter/material.dart';
import 'package:yogaflutter/pages/third_page/duration.dart';
import 'package:yogaflutter/models/lesson.dart';
import 'dart:convert';
import 'package:yogaflutter/pages/third_page/titolo.dart';
import 'package:yogaflutter/pages/third_page/image_banner.dart';


class TypeBeginnerYoga extends StatelessWidget {
  final Lesson lesson;
  String title;
  String description;
  String image;
  TypeBeginnerYoga({Key key, @required this.lesson}) : super (key: key);
  String clickedType = "Beginners Yoga";

  @override
  Widget build(BuildContext context) {

    Future<void> createList() async {
      List<Widget> items = new List<Widget>();
      String dataString = await DefaultAssetBundle.of(context).loadString("./load_json/instructors.json");
      
      List<dynamic> dataJSON = jsonDecode(dataString);
      dataJSON.forEach((object) {
        if (object["typeTitle"].toString() == clickedType) {
          print(clickedType);
          lesson.typeofyoga = clickedType;
          title = object["typeTitle"].toString();
          description = object["placeItems"].toString();
          image = object["placeItems"].toString();
        }
      });
    }

    

    return new Scaffold(
      appBar: new AppBar(backgroundColor: Colors.indigo[400],),
      body: ListView(
        children: <Widget>[
          Container(
            child: FutureBuilder(
            initialData: <Widget>[Text("")],
            future: createList(),
            builder: (context,snapshot){
              if(snapshot.hasError != false){
                return Column(
                  children: <Widget>[
                    //ImageBanner(image),
                    Titolo(titolo: title),
                    Center(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            description,
                            style: TextStyle(fontFamily: 'Montserrat', fontSize: 12),
                          ),
                        )
                      )
                    ),
                    Titolo(titolo: 'Numero di allievi'),
                    
                  ],
                );
              } 
              else {
                return CircularProgressIndicator();
              }
            }),
          )
        ],
      ),
    );
  }
} 