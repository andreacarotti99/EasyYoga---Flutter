import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:yogaflutter/models/lesson.dart';


class TimePickerButton extends StatefulWidget {
  final Lesson lesson;
  TimePickerButton({Key key, @required this.lesson}) : super(key: key);
  @override
  TimePickerButtonState createState() => TimePickerButtonState();
}

class TimePickerButtonState extends State<TimePickerButton> {
  Lesson lesson;
  String _time = "Seleziona l'orario";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)
                ),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      onConfirm: (time) {
                        print('confirm $time');
                        _time =
                        '${time.hour} : ${time.minute} : ${time.second}';
                        setState(() {});
                        //lesson.time = _time;
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.it
                  );
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.teal,
                                ),
                                Text(
                                  " $_time",
                                  style: TextStyle(
                                      color: Colors.indigo[400],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Cambia",
                        style: TextStyle(
                            color: Colors.indigo[400],
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0
                        ),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}