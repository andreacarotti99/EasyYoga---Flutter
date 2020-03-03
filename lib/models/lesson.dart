class Lesson {
  String duration;
  String attendees;
  String typeofyoga;
  String day;
  String time;
  String instructor;
  String cap;

  Lesson(
    this.duration,
    this.attendees,
    this.typeofyoga,
    this.day,
    this.time,
    this.instructor,
    this.cap,
  );

  Map<String, dynamic> toJson() => {
    'duration': duration,
    'attendees': attendees,
    'typeofyoga': typeofyoga,
    'day': day,
    'time': time,
    'instructor': instructor,
    'cap': cap,
  };
}