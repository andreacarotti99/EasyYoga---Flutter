import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yogaflutter/models/lesson.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yogaflutter/pages/fourth_page/time_picker_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
 


class PagePickDate extends StatelessWidget {
    final Lesson lesson;
    PagePickDate({Key key, @required this.lesson}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(backgroundColor: Colors.indigo[400],),
      body: new Center(
        child: new CalendarPage(lesson: lesson)
      )
    );
  }
}

class CalendarPage extends StatefulWidget {
  final Lesson lesson;
  CalendarPage({Key key, @required this.lesson}) : super (key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController _controller;
  Lesson lesson;
  _CalendarPageState({this.lesson});


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              initialCalendarFormat: CalendarFormat.twoWeeks,
              calendarStyle: CalendarStyle(
                todayColor: Colors.deepPurple,
                selectedColor: Theme.of(context).primaryColor,
                todayStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white
                )
              ),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, events) { //se seleziono una data allora succede questo
                print(date.toIso8601String());
                String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(date);
                //lesson.day = formattedDate;
                print(formattedDate);
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )
                ),
              ),
              calendarController: _controller,
            ),
            TimePickerButton(lesson: lesson),
            Center(
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) =>
                      PageChooseInstructor (lesson: lesson,)));
                },
                child: Text(
                  'Prosegui',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 16)
                )
              )
            )
          ],
        ),
      ),
    );
  }
}





//FIFTH PAGE INTERACTING WITH FIREBASE 

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
        itemCount: slideList.length +1,
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