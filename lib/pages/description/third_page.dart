import 'package:flutter/material.dart';
import 'package:yogaflutter/models/lesson.dart';
import 'package:yogaflutter/pages/whenlesson/pick_date_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TypeBeginnerYoga extends StatefulWidget {
  String clickedNome;
  String clickedDescrizione;
  String clickedImmagine;
  TypeBeginnerYoga({Key key, @required this.clickedNome, @required this.clickedDescrizione, @required this.clickedImmagine}) : super (key: key);

  @override
  _TypeBeginnerYogaState createState() => _TypeBeginnerYogaState();
}

class _TypeBeginnerYogaState extends State<TypeBeginnerYoga> {
  Lesson lesson;

 

  Future<void> checkAcquiredInfo() async {
    var documenti = await Firestore.instance.collection("typeofyogas").getDocuments();
    var allDocsInCollection = documenti.documents;
    
    var titolo = await Firestore.instance.collection("typeofyogas").where('nome', isEqualTo: widget.clickedNome).getDocuments();
    print(titolo);
    // var descrizione = 
    // var immagine = 
  }



  @override
  Widget build(BuildContext context) {    
    return new Scaffold(
      appBar: new AppBar(backgroundColor: Colors.indigo[400],),
      body: FutureBuilder(
        future: checkAcquiredInfo(),
        builder: (context, snapshot) {
            return Column(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.expand(height: 200.0),
                  decoration: BoxDecoration(color: Colors.grey),
                  child: Image(
                    image: NetworkImage(widget.clickedImmagine),
                    fit: BoxFit.cover,
                  )),
                Center(
                  child: Container(
                    
                      padding: EdgeInsets.all(16.0),
                        child: Text(
                        widget.clickedNome,
                        style: TextStyle(fontFamily: 'Montserrat', fontSize: 20),
                      ),
                  )
                ),
                Center(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        widget.clickedDescrizione,
                        style: TextStyle(fontFamily: 'Montserrat', fontSize: 12),
                      ),
                    )
                  )
                ),
              Center(
                  child: Container(
                      padding: EdgeInsets.all(16.0),
                        child: Text(
                        'Numero di Allievi',
                        style: TextStyle(fontFamily: 'Montserrat', fontSize: 20),
                      ),
                  )
                ),
              Center(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) => PagePickDate(lesson: lesson)));
                    },
                    child: Text(
                      'Prosegui',
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 16)
                      )
                  )
                )
              ],
            );
          //}
        }
      )
    );
  }
} 