import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:yogaflutter/models/lesson.dart';

class PageChooseInstructor extends StatelessWidget {
  final Lesson lesson;
  PageChooseInstructor({Key key, @required this.lesson}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        body: FirestoreSlideshow()    
      ),
    );
  }
}

class FirestoreSlideshow extends StatefulWidget {
   createState() => FirestoreSlideshowState();
}

class FirestoreSlideshowState extends State<FirestoreSlideshow> {
  final PageController ctrl = PageController(viewportFraction: 0.8); //to view not 100% but 80% of the screen
  final Firestore db = Firestore.instance;
  Stream slides; //this is to interact with the db
  String activeTag = 'favorites';
  int currentPage = 0;

  @override
  void initState() {
    _queryDb(); 
    ctrl.addListener(() {
      int next = ctrl.page.round();
      if(currentPage != next) {
        setState((){
          currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: slides,
      initialData: [],
      builder: (context, AsyncSnapshot snap) {
        List slideList = snap.data.toList();
        return PageView.builder( 
        controller: ctrl,
        itemCount: slideList.length + 1,
        itemBuilder: (context, int currentIdx) {
          if (currentIdx == 0) {
            return _buildTagPage();
          } else if (slideList.length >= currentIdx) {
            bool active = currentIdx == currentPage;
            return _buildStoryPage(slideList[currentIdx - 1], active);
          }
        }
        );
      }
    );
    //TODO
  }

  Stream _queryDb({ String tag = 'favorites'}){
  //Make a query
  Query query = db.collection('stories').where('tags', arrayContains: tag);
  //Map the documents to the data payload
  slides = query.snapshots().map((list) => list.documents.map((doc) => doc.data));
  //Update the active tag
  setState(() {
    activeTag = tag;
  });
  }

    // Builder Functions
    _buildStoryPage(Map data, bool active) {
     // Animated Properties
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(data['img']),
        ),

        boxShadow: [BoxShadow(color: Colors.black87, blurRadius: blur, offset: Offset(offset, offset))]
      ),

    );
    }

  _buildTagPage() {
    return Container(child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
      
        children: [
          Text('Your Stories', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
          Text('FILTER', style: TextStyle( color: Colors.black26 )),
          _buildButton('favorites'),
          _buildButton('happy'),
          _buildButton('sad')
        ],
      )
    );
  }

  _buildButton(tag) {
  Color color = tag == activeTag ? Colors.purple : Colors.white;
  return FlatButton(color: color, child: Text('#$tag'), onPressed: () => _queryDb(tag: tag));
  }
}










  

  