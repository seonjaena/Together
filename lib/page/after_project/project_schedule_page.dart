import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ProjectSchedulePage extends StatefulWidget {
  @override
  _ProjectSchedulePageState createState() => _ProjectSchedulePageState();
}

class _ProjectSchedulePageState extends State<ProjectSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 400,
              child: SfCalendar(
                view: CalendarView.month,
              ),
            ),
            ListTile(
              title: Text('hi'),
            )
          ],
        ),
      ),
    );
  }
}
