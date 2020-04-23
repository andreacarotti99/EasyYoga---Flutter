import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yogaflutter/models/lesson.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:yogaflutter/pages/chooseinstructor/select_instructor.dart';
import 'package:yogaflutter/pages/whenlesson/check_occupato.dart';

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
  
  bool b1 = false; bool b2 = false; bool b3 = false;
  bool b4 = false; bool b5 = false; bool b6 = false;
  Color colorb1 = Colors.grey; Color colorb2 = Colors.grey; Color colorb3 = Colors.grey;
  Color colorb4 = Colors.grey; Color colorb5 = Colors.grey; Color colorb6 = Colors.grey;
  String formattedDay = '';
  MaterialColor colorChanged;
  CalendarController _controller;
  Lesson lesson;
  _CalendarPageState({this.lesson});

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    var today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    controllaGiorno(today);
    if (formattedDay != ''){
      controllaGiorno(formattedDay);
    }
  }

  Future<void> controllaGiorno(String formattedDay) async {
    var b1 = await controllaSeOccupatoIlGiorno(formattedDay, '10:00');
    var b2 = await controllaSeOccupatoIlGiorno(formattedDay, '11:00');
    var b3 = await controllaSeOccupatoIlGiorno(formattedDay, '12:00');
    var b4 = await controllaSeOccupatoIlGiorno(formattedDay, '13:00');
    var b5 = await controllaSeOccupatoIlGiorno(formattedDay, '14:00');
    var b6 = await controllaSeOccupatoIlGiorno(formattedDay, '15:00');
      
    setState(() {
      b1 ? colorb1 = Colors.red : colorb1 = Colors.grey;
      b2 ? colorb2 = Colors.red : colorb2 = Colors.grey;
      b3 ? colorb3 = Colors.red : colorb3 = Colors.grey;
      b4 ? colorb4 = Colors.red : colorb4 = Colors.grey; 
      b5 ? colorb5 = Colors.red : colorb5 = Colors.grey;
      b6 ? colorb6 = Colors.red : colorb6 = Colors.grey;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,  
          children: <Widget>[
            TableCalendar(
              initialCalendarFormat: CalendarFormat.week,
              availableCalendarFormats: const {CalendarFormat.week : 'Week'},
              calendarStyle: CalendarStyle(
                todayColor: Colors.deepPurple,
                holidayStyle: TextStyle(color: Colors.grey),
                weekendStyle: TextStyle(color: Colors.black),
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

                formattedDay = DateFormat('yyyy-MM-dd').format(date).toString();
                controllaGiorno(formattedDay);

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
                        b1 ? Scaffold.of(context).showSnackBar(SnackBar(content: Text('Orario selezionato non disponibile'))) : {};
                    },
                    child: Text('10:00'),
                    color: colorb1
                  ),
                  FlatButton(
                    onPressed: (){
                      b2 ? Scaffold.of(context).showSnackBar(SnackBar(content: Text('Orario selezionato non disponibile'))) : {};
                    },
                    child: Text('11:00'),
                    color: colorb2
                  ),
                  FlatButton(
                    onPressed: (){
                      b3 ? Scaffold.of(context).showSnackBar(SnackBar(content: Text('Orario selezionato non disponibile'))) : {};
                    },
                    child: Text('12:00'),
                    color: colorb3
                  )
                ]
              ),
            ),
            new Container(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget> [
                  FlatButton(
                    onPressed: (){
                        b4 ? Scaffold.of(context).showSnackBar(SnackBar(content: Text('Orario selezionato non disponibile'))) : {};
                    },
                    child: Text('13:00'),
                    color: colorb4
                  ),
                  FlatButton(
                    onPressed: (){
                      b5 ? Scaffold.of(context).showSnackBar(SnackBar(content: Text('Orario selezionato non disponibile'))) : {};
                    },
                    child: Text('14:00'),
                    color: colorb5
                  ),
                  FlatButton(
                    onPressed: (){
                      b6 ? Scaffold.of(context).showSnackBar(SnackBar(content: Text('Orario selezionato non disponibile'))) : {};
                    },
                    child: Text('15:00'),
                    color: colorb6
                  )
                ]
              ),
            ),
            //TimePickerButton(),
            NextButton(lesson: lesson),
            
            
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