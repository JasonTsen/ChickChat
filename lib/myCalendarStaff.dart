import 'package:chickchat/event_firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chickchat/add_event.dart';
import 'package:chickchat/view_eventStaff.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:chickchat/event.dart';

class MyCalendarStaff extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calendar',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: HomePage(),
      routes: {
        "add_event": (_) => AddEventPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  //========================FirebaseAuth userAuth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
  }
  Map<DateTime, List<dynamic>> _groupEvents(List<EventModel> events){
    Map<DateTime, List<dynamic>> data = {};
    events.forEach((event){
      DateTime date = DateTime(event.eventDate.year, event.eventDate.month,
          event.eventDate.day, 12);
      if(data[date]==null) data[date] = [] ;
      data[date].add(event);
    });
    return data;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar' ,style: TextStyle(fontWeight : FontWeight.bold,)),
      ),
      body: StreamBuilder<List<EventModel>>(
          stream: eventDBS.streamList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<EventModel> allEvents = snapshot.data;
              if (allEvents.isNotEmpty) {
                _events = _groupEvents(allEvents);
              }
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TableCalendar(
                    events: _events,
                    initialCalendarFormat: CalendarFormat.month,
                    calendarStyle: CalendarStyle(
                        canEventMarkersOverflow: true,
                        todayColor: Colors.grey,
                        selectedColor: Theme
                            .of(context)
                            .primaryColor,
                        todayStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white)),
                    headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      formatButtonTextStyle: TextStyle(color: Colors.white),
                      formatButtonShowsNext: false,
                    ),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: (date, events, event) {
                      setState(() {
                        _selectedEvents = events;
                      });
                    },
                    builders: CalendarBuilders(
                      selectedDayBuilder: (context, date, events) =>
                          Container(
                              margin: const EdgeInsets.all(4.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(color: Colors.white),
                              )),
                      todayDayBuilder: (context, date, events) =>
                          Container(
                              margin: const EdgeInsets.all(4.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 21.0),
                              )),
                    ),
                    calendarController: _controller,
                  ),
                  ..._selectedEvents.map((event) =>
                      Container(decoration: BoxDecoration(
                        border: Border.all(width: 0.8),borderRadius: BorderRadius.circular(12.0),
                      ),
                          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                          child: ListTile(
                            title: Text(event.eventTimeStart + ' - ' + event.eventTimeEnd + '     ' + event.title),

                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          StaffEventDetailsPage(
                                            event: event,
                                          )));
                            },
                          )),
                  )],
              ),
            );
          }
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   tooltip: 'Add your event',
      //   onPressed: () => Navigator.pushNamed(context, 'add_event'),
      // ),
    );

  }
}

