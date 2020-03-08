import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:yogaflutter/models/lesson.dart';

//FIFTH PAGE INTERACTING WITH FIREBASE 

//Prima costruisco lo statelesswidget con all'interno lo scaffold che mi realizza la pagina 
class PageChooseInstructor extends StatelessWidget {
  final Lesson lesson;
  PageChooseInstructor({Key key, @required this.lesson}) : super (key: key);
  final PageController ctrl = PageController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FirestoreSlideshow()    
    );
  }
}

//Stateful Widget che manda la richiesta al db di firestore e mi permette di visualizzare così un'immagine
//svolgendo una NetworkImage (in firestore è salvato solamente il link all'immagine su un sito web)
class FirestoreSlideshow extends StatefulWidget {
  @override
  _FirestoreSlideshowState createState() => _FirestoreSlideshowState();
}

class _FirestoreSlideshowState extends State<FirestoreSlideshow> {
  final PageController ctrl = PageController(viewportFraction: 0.8); //to view not 100% but 80% of the screen
  final Firestore db = Firestore.instance;
  Stream slides; //this is to interact with the database
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
      boxShadow: [BoxShadow(color: Colors.black87, blurRadius: blur, offset: Offset(offset, offset))],
    ),
    child: Center(
      child: RaisedButton(
        onPressed: (){},
        child: Text('Conferma istruttore')
      ),
    )
  );
  }

  _buildTagPage() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Scegli il tuo Istruttore', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
          Text('FILTRA', style: TextStyle( color: Colors.black26 )),
          _buildButton('favorites'),
          _buildButton('happy'),
          _buildButton('sad')
        ],
      )
    );
  }

  _buildButton(tag) {
  Color color = tag == activeTag ? Colors.purple : Colors.white;
  return FlatButton(
    color: color,
    child: Text('#$tag'),
    onPressed: () => _queryDb(tag: tag)
  );
  }
  
}








  

  