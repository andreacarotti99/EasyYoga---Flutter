import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yogaflutter/models/lesson.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:yogaflutter/pages/fifth_page/select_instructor.dart';



class GetAppointments {
  Future<QuerySnapshot> getDailyAppointments(String formattedDay) {
    return Firestore.instance
    .collection('appointments')
    .where('data', isEqualTo: formattedDay)
    .getDocuments();
  }
}


class PagePickDate extends StatelessWidget {
    final Lesson lesson;
    PagePickDate({Key key, @required this.lesson}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(backgroundColor: Colors.indigo[400],),
      body: new Center(
        child: new CalendarPage(lesson: lesson),
      ),
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
  bool dailyAppointmentsFlag10 = false;
  bool dailyAppointmentsFlag11 = false;
  bool dailyAppointmentsFlag12 = false;

  MaterialColor colorChanged;
  CalendarController _controller;
  Lesson lesson;
  _CalendarPageState({this.lesson});
  var appointments;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    var today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    GetAppointments().getDailyAppointments(today).then((QuerySnapshot docs) {
      if(docs.documents.isNotEmpty) {
        appointments = docs.documents[0].data;
        if(appointments['ora']== '10:00'){
            dailyAppointmentsFlag10 = true;
        }
        if (appointments['ora']== '11:00'){
          dailyAppointmentsFlag11 = true;
        }
        if(appointments['ora']== '12:00'){
          dailyAppointmentsFlag12 = true;
        }
      }
      else {
        dailyAppointmentsFlag10 = false;
        dailyAppointmentsFlag11 = false;
        dailyAppointmentsFlag12 = false;
        appointments = [];
      }
      docs.documents.isNotEmpty ? print(appointments['ora']) : print('Questo giorno non ha lezioni fissate');
    });
  }

  Future<void> checkAvailability(String day) async {
    
      GetAppointments().getDailyAppointments(day).then((QuerySnapshot docs) {
        if(docs.documents.isNotEmpty) {
          appointments = docs.documents[0].data;
          if(appointments['ora']== '10:00'){
            dailyAppointmentsFlag10 = true;
          }
          if (appointments['ora']== '11:00'){
            dailyAppointmentsFlag11 = true;
          }
          if(appointments['ora']== '12:00'){
            dailyAppointmentsFlag12 = true;
          }

        }
        else {
          dailyAppointmentsFlag10 = false;
          dailyAppointmentsFlag11 = false;
          dailyAppointmentsFlag12 = false;
        }
        setState((){});
        docs.documents.isNotEmpty ? print(appointments['ora']) : print('Questo giorno non ha lezioni fissate');
        
      });

  }

  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: <Widget>[
            TableCalendar(
              initialCalendarFormat: CalendarFormat.week,
              availableCalendarFormats: const {CalendarFormat.week : 'Week'},
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
              onDaySelected: (date, events) { 

                String formattedDay = DateFormat('yyyy-MM-dd').format(date);
                print(formattedDay);
                //lesson.day = formattedDate;
                checkAvailability(formattedDay);                

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

    
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text(
                  'Slot Disponibili',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                  )
                ),
              ],
            ),
            
            new Container(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget> [
                  FlatButton(
                    onPressed: (){
                      if (dailyAppointmentsFlag10 == true){
                        Scaffold
                          .of(context)
                          .showSnackBar(SnackBar(content: Text('Orario selezionato non disponibile')));
                      }
                    },
                    child: Text('10:00'),
                    color: dailyAppointmentsFlag10 ? Colors.red : Colors.grey,
                  ),
                  FlatButton(
                    onPressed: (){},
                    child: Text('11:00'),
                    color: dailyAppointmentsFlag11 ? Colors.red : Colors.grey,
                  ),
                  FlatButton(
                    onPressed: (){},
                    child: Text('12:00'),
                    color: dailyAppointmentsFlag12 ? Colors.red : Colors.grey,
                  )
                ]
              ),
            ),

            //TimePickerButton(),
            NextButton(lesson: lesson)
            
          ],
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final Lesson lesson;
  NextButton({Key key, @required this.lesson}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context) => PageChooseInstructor (lesson: lesson)));
        },
        child: Text('Prosegui',style: TextStyle(fontFamily: 'Montserrat', fontSize: 16)
        )
      )
    );
  }
}
