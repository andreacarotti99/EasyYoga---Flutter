import 'package:flutter/material.dart';
import './durationattendees.dart';
import 'package:yogaflutter/models/lesson.dart';

class PageYogaTypes extends StatelessWidget {

  final Lesson lesson;
  PageYogaTypes({Key key, @required this.lesson}) : super (key: key);



  @override
  Widget build(BuildContext context) {

    

    return new Scaffold(
      appBar: new AppBar(backgroundColor: Colors.indigo[400],),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Beginners Yoga'),
            onTap: () { Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => TypeBeginnerYoga(lesson: lesson,)));
            }
          ),


          ListTile(
          leading: Icon(Icons.phone),
          title: Text('Vinyasa Yoga'),
          ),
          ListTile(
          leading: Icon(Icons.phone),
          title: Text('Meditation'),
          ),
          ListTile(
          leading: Icon(Icons.phone),
          title: Text('Kids Yoga'),
          ),
          ListTile(
          leading: Icon(Icons.phone),
          title: Text('Budokon'),
          ),

        ],
      ),
    );
  }
} 