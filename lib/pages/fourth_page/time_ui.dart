/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetAppointments {
  getDailyAppointments(String formattedDay) {
    return Firestore.instance
    .collection('appointments')
    .where('data', isEqualTo: formattedDay)
    .orderBy('data', descending: true)
    .getDocuments();
  }
}


class TimeSlotButtons extends StatefulWidget {
  @override
  _TimeSlotButtonsState createState() => _TimeSlotButtonsState();
}

class _TimeSlotButtonsState extends State<TimeSlotButtons> {
  var appointments;
  bool dailyAppointmentsFlag = false;

  

  @override
  void initState() {
    super.initState();
    GetAppointments().getDailyAppointments(formattedDay).then((QuerySnapshot docs) {
      if(docs.documents.isNotEmpty) {
        dailyAppointmentsFlag = true;
        appointments = docs.documents[0].data;
      }
      else {
        dailyAppointmentsFlag = false;
      }
    });
  }


  void checkAvailability(String formattedDay) {
    setState((){
      GetAppointments().getDailyAppointments(formattedDay).then((QuerySnapshot docs) {
        if(docs.documents.isNotEmpty) {
          dailyAppointmentsFlag = true;
          appointments = docs.documents[0].data;
        }
        else {
          dailyAppointmentsFlag = false;
        }
      });
    });
  }

  final timeTypes = ["10:00 AM", "11:00 AM", "12:00 AM","1:00 PM","2:00 PM","3:00 PM" ]
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





//questo va chiamato ogni volta che viene cambiato il giorno



getYear(DateTime inputVal) {
  String processedYear;
  processedYear = inputVal.year.toString();
  return processedYear;
}

getDay(DateTime inputVal) {
  String processedDay;
  processedDay = inputVal.day.toString();
  return processedDay;
}

getTime(DateTime inputVal) {
  String processedTime;
  processedTime = inputVal.hour.toString();
  return processedTime;
}  */