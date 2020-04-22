import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => new _CalendarState();
}

final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
int nric;

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

class _CalendarState extends State<Calendar> {
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

  void displayMarks(){
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
  }

  Widget myCircleAvatar(String day, Color color){
    return Center(
        child: CircleAvatar(
          child: Text(
            day, style: TextStyle(color: Colors.black),),
          backgroundColor: color
        )
    );
  }

  @override
  Widget build(BuildContext context) {

    cHeight = MediaQuery.of(context).size.height;
    displayMarks();


    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      height: cHeight * 0.60,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      todayButtonColor: Colors.blue[200],
      daysHaveCircularBorder: false,
      thisMonthDayBorderColor: Colors.black,
      customDayBuilder: (   /// you can provide your own build function to make custom day containers
          bool isSelectable,
          int index,
          bool isSelectedDay,
          bool isToday,
          bool isPrevMonthDay,
          TextStyle textStyle,
          bool isNextMonthDay,
          bool isThisMonthDay,
          DateTime day,
          ) {
        /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
        /// This way you can build custom containers for specific days only, leaving rest as default.

        if(nric==null) {
            return null;
          }
        else {
          if(nric.isEven){
            if (day.day.isEven) {
              return myCircleAvatar(day.day.toString(), Colors.green);
            } else {
              return myCircleAvatar(day.day.toString(), Colors.red);
            }
          }
          else {
            if (day.day.isEven) {
              return myCircleAvatar(day.day.toString(), Colors.red);
            } else {
              return myCircleAvatar(day.day.toString(), Colors.green);
            }
          }

        }
      },
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
        title: new Text("Can I go to the Market?"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      //filled: true,
                      //fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(2)

                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink, width: 2.0),
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
                    nric = int.parse(value);
                    setState(() {

                    });
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
               /*   presentDates = [];
                  absentDates = [];
                  if(int.parse(nric).isEven){
                    print('your number is even');
                    for(int i=0;i<30;i++){
                      if(i.isEven){
                        presentDates.add(DateTime(2020,4,i));
                      }
                      if(i.isOdd){
                        absentDates.add(DateTime(2020,4,i));
                      }
                    }
                    displayMarks();
                    setState(() {});
                  }
                  else{
                    for(int i=0;i<30;i++){
                      if(i.isOdd){
                        presentDates.add(DateTime(2020,4,i));
                      }
                      if(i.isEven){
                        absentDates.add(DateTime(2020,4,i));
                      }
                    }
                    displayMarks();
                    setState(() {});
                    print('your number is odd');
                  }
*/
                  print('my nric value is ' + nric.toString());
                }
              },
              child: Text('Submit', style: TextStyle(color: Colors.white)),
            ),
            _calendarCarouselNoHeader,
            //markerRepresent(Colors.green, "Can Go"),
            //markerRepresent(Colors.red, "Cannot Go"),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               CircleAvatar(
                 backgroundColor: Colors.green,
               ),
               SizedBox(width: 15.0),
               Text("Can Go", style: TextStyle(fontSize: 18),),
               SizedBox(width: 25.0),
               CircleAvatar(
                 backgroundColor: Colors.red,
               ),
               SizedBox(width: 15.0),
               Text("Cannot Go", style: TextStyle(fontSize: 18),),
             ],
           ),

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