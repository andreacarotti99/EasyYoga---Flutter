/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TimeSlotButtons extends StatefulWidget {
  @override
  _TimeSlotButtonsState createState() => _TimeSlotButtonsState();
}

class _TimeSlotButtonsState extends State<TimeSlotButtons> {
  var appointments;
  bool dailyAppointmentsFlag = false;

  @override
  void initState() {};


  setState((){});


MaterialColor checkCorrespondence(int index, var timeTypes, var appointments){
  setState((){
  if (timeTypes[index] == appointments['ora']){
    return Colors.red;
  }
  else return Colors.grey;
  });
}

  final timeTypes = ["10:00", "11:00", "12:00","13:00","14:00","15:00" ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              scrollDirection: Axis.vertical,
              primary: false,
              children: List.generate(timeTypes.length, (index){
                return FlatButton(
                  color: checkCorrespondence(index, timeTypes, appointments),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Text(timeTypes[index]),
                    ]
                  ),
                  onPressed: () {

                    //saving the time chosen in the lesson variable

                  },
                );
              })
            )
          )
        ],
      )
      
    );
  }
}
 */
/*
return GridView.count (
  crossAxisCount: 3,
  children: List.generate(6, (index) {
    return new Card(
      elevation: 8.0,
      child: new Container(
        child: new Text("$timeTypes[index]")
      )
    );
  }
)
*/









