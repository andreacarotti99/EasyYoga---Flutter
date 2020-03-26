import 'package:flutter/material.dart';
import 'package:yogaflutter/pages/third_page/third_page.dart';
import 'package:yogaflutter/models/lesson.dart';
import 'dart:convert';

class PageYogaTypes extends StatelessWidget {
  final Lesson lesson;
  PageYogaTypes({Key key, @required this.lesson}) : super (key: key);
  String clickedType;

  @override
  Widget build(BuildContext context) {
    Future<List<Widget>> createList() async {
      List<Widget> items = new List<Widget>();
      String dataString =
          await DefaultAssetBundle.of(context).loadString("./load_json/instructors.json");
      List<dynamic> dataJSON = jsonDecode(dataString);

      dataJSON.forEach((object) { 
        String finalString= "";
        List<dynamic> dataList = object["placeItems"];

        dataList.forEach((item){
          finalString = finalString + item;
        });
        //per ogni elemento in json che possiedo in instructors costruisce un elemento
        items.add(Padding(padding: EdgeInsets.all(2.0),
        child: FlatButton(
            onPressed: () {
              //salvo il tipo di yoga cliccato
              clickedType = object["typeTitle"];
              print(clickedType);
              lesson.typeofyoga = clickedType;
              Navigator.of(context).push(
              new MaterialPageRoute(builder: (BuildContext context) => TypeBeginnerYoga(lesson: lesson,)));
            },
            child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2.0,
                  blurRadius: 5.0
                ),
              ]
            ),
            margin: EdgeInsets.all(5.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),bottomLeft: Radius.circular(10.0)),
                  child: Image.asset(object["typeImage"],width: 80,height: 80,fit: BoxFit.cover,),
                ),
                SizedBox(
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(object["typeTitle"]),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0,bottom: 2.0),
                          child: Text(finalString, style: TextStyle(fontSize: 12.0,color: Colors.black54,),),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),));
      });

      return items;
    }

    

    return new Scaffold(
      appBar: new AppBar(backgroundColor: Colors.indigo[400],),
      body: ListView(
        children: <Widget>[
          Container(child: FutureBuilder(
                    initialData: <Widget>[Text("")],
                    future: createList(),
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: snapshot.data,
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
          )
        ],
      ),
    );
  }
} 