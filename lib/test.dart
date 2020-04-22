
import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

class CalendarPage2 extends StatefulWidget {
  @override
  _CalendarPage2State createState() => new _CalendarPage2State();
}

List<DateTime> presentDates = [
  DateTime(2020, 2, 1),
  DateTime(2020, 2, 3),
  DateTime(2020, 2, 4),
  DateTime(2020, 2, 5),
  DateTime(2020, 2, 6),
  DateTime(2020, 2, 9),
  DateTime(2020, 2, 10),
  DateTime(2020, 2, 11),
  DateTime(2020, 2, 15),
  DateTime(2020, 2, 11),
  DateTime(2020, 2, 15),
];
List<DateTime> absentDates = [
  DateTime(2020, 2, 2),
  DateTime(2020, 2, 7),
  DateTime(2020, 2, 8),
  DateTime(2020, 2, 12),
  DateTime(2020, 2, 13),
  DateTime(2020, 2, 14),
  DateTime(2020, 2, 16),
  DateTime(2020, 2, 17),
  DateTime(2020, 2, 18),
  DateTime(2020, 2, 17),
  DateTime(2020, 2, 18),
];

class _CalendarPage2State extends State<CalendarPage2> {
  DateTime _currentDate2 = DateTime.now();
  static Widget _presentIcon(String day) => Container(
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.all(
        Radius.circular(1000),
      ),
    ),
    child: Center(
      child: Text(
        day,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
  static Widget _absentIcon(String day) => Container(
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.all(
        Radius.circular(1000),
      ),
    ),
    child: Center(
      child: Text(
        day,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  CalendarCarousel _calendarCarouselNoHeader;

  var len = 9;
  double cHeight;

  @override
  Widget build(BuildContext context) {
    String nric;
    final _formKey = GlobalKey<FormState>();

    //cHeight = MediaQuery.of(context).size.height;
    for (int i = 0; i < len; i++) {
      _markedDateMap.add(
        presentDates[i],
        new Event(
          date: presentDates[i],
          title: 'Event 5',
          icon: _presentIcon(
            presentDates[i].day.toString(),
          ),
        ),
      );}

    for (int i = 0; i < len; i++) {
      _markedDateMap.add(
        absentDates[i],
        new Event(
          date: absentDates[i],
          title: 'Event 5',
          icon: _absentIcon(
            absentDates[i].day.toString(),
          ),
        ),
      );
    }


    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      //height: cHeight * 0.70,
      height: 400,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      todayButtonColor: Colors.blue[200],
      daysHaveCircularBorder: false,
      thisMonthDayBorderColor: Colors.black,
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal:
      null, // null for not showing hidden events indicator
      markedDateIconBuilder: (event) {
        return event.icon;
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: Text('Can I Go To The Market?'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink, width: 2.0),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2)
                      ),
                      hintText: 'Enter the last digit of your NRIC'
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field cannot be empty!';
                    }
                    return null;
                  },
                  onSaved: (value){
                    nric = value;
                  },
                ),
              ),
            ),
            RaisedButton(
              color: Colors.blue,
              onPressed: () {
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                       if(int.parse(nric).isEven){
                    print('your number is even');
                    for(int i=0;i<30;i++){
                      if(i.isEven){
                        presentDates.add(DateTime(2020,i,4));
                      }
                      if(i.isOdd){
                        absentDates.add(DateTime(2020,i,4));
                      }
                    }
                    setState(() {});
                  }
                  else{
                    for(int i=0;i<30;i++){
                      if(i.isOdd){
                        presentDates.add(DateTime(2020,i,4));
                      }
                      if(i.isEven){
                        absentDates.add(DateTime(2020,i,4));
                      }
                    }
                    setState(() {});
                    print('your number is odd');
                  }

                  print('my nric value is ' + nric);
                }
              },
              child: Text('Submit', style: TextStyle(color: Colors.white)),
            ),
            _calendarCarouselNoHeader,
         /*   Row(
              children: <Widget>[
                markerRepresent(Colors.green, "Can Go"),
                markerRepresent(Colors.red, "Cannot Go"),
              ],
            )*/
            markerRepresent(Colors.green, "Can Go"),
            markerRepresent(Colors.red, "Cannot Go"),
          ],
        ),
      ),
    );
  }

  Widget markerRepresent(Color color, String data) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        radius: cHeight * 0.022,
      ),
      title: new Text(
        data,
      ),
    );
  }
}