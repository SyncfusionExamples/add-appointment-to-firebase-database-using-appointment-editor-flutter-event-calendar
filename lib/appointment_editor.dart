// // @dart=2.9
// part of event_calendar;

import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/color_picker.dart';
import 'package:flutter_application/timezone_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_application/main.dart';

class AppointmentEditor extends StatefulWidget {
  const AppointmentEditor({super.key});

  @override
  AppointmentEditorState createState() => AppointmentEditorState();
}

class AppointmentEditorState extends State<AppointmentEditor> {
  Widget _getAppointmentEditor(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: <Widget>[
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
            leading: const Text(''),
            title: TextField(
              controller: TextEditingController(text: subject),
              onChanged: (String value) {
                subject = value;
              },
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Add title',
              ),
            ),
          ),
          const Divider(height: 1.0, thickness: 1),
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            leading: Icon(Icons.access_time, color: Colors.black54),
            title: Row(
              children: <Widget>[
                const Expanded(child: Text('All-day')),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Switch(
                      value: isAllDay,
                      onChanged: (bool value) {
                        setState(() {
                          isAllDay = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            leading: const Text(''),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: GestureDetector(
                    child: Text(
                      DateFormat('EEE, MMM dd yyyy').format(startDate),
                      textAlign: TextAlign.left,
                    ),
                    onTap: () async {
                      final DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: startDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );

                      if (date != null && date != startDate) {
                        setState(() {
                          final Duration difference = endDate.difference(
                            startDate,
                          );
                          startDate = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            startTime.hour,
                            startTime.minute,
                            0,
                          );
                          endDate = startDate.add(difference);
                          endTime = TimeOfDay(
                            hour: endDate.hour,
                            minute: endDate.minute,
                          );
                        });
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child:
                      isAllDay
                          ? const Text('')
                          : GestureDetector(
                            child: Text(
                              DateFormat('hh:mm a').format(startDate),
                              textAlign: TextAlign.right,
                            ),
                            onTap: () async {
                              final TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                  hour: startTime.hour,
                                  minute: startTime.minute,
                                ),
                              );

                              if (time != null && time != startTime) {
                                setState(() {
                                  startTime = time;
                                  final Duration difference = endDate
                                      .difference(startDate);
                                  startDate = DateTime(
                                    startDate.year,
                                    startDate.month,
                                    startDate.day,
                                    startTime.hour,
                                    startTime.minute,
                                    0,
                                  );
                                  endDate = startDate.add(difference);
                                  endTime = TimeOfDay(
                                    hour: endDate.hour,
                                    minute: endDate.minute,
                                  );
                                });
                              }
                            },
                          ),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            leading: const Text(''),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: GestureDetector(
                    child: Text(
                      DateFormat('EEE, MMM dd yyyy').format(endDate),
                      textAlign: TextAlign.left,
                    ),
                    onTap: () async {
                      final DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: endDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );

                      if (date != null && date != endDate) {
                        setState(() {
                          final Duration difference = endDate.difference(
                            startDate,
                          );
                          endDate = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            endTime.hour,
                            endTime.minute,
                            0,
                          );
                          if (endDate.isBefore(startDate)) {
                            startDate = endDate.subtract(difference);
                            startTime = TimeOfDay(
                              hour: startDate.hour,
                              minute: startDate.minute,
                            );
                          }
                        });
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child:
                      isAllDay
                          ? const Text('')
                          : GestureDetector(
                            child: Text(
                              DateFormat('hh:mm a').format(endDate),
                              textAlign: TextAlign.right,
                            ),
                            onTap: () async {
                              final TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                  hour: endTime.hour,
                                  minute: endTime.minute,
                                ),
                              );

                              if (time != null && time != endTime) {
                                setState(() {
                                  endTime = time;
                                  final Duration difference = endDate
                                      .difference(startDate);
                                  endDate = DateTime(
                                    endDate.year,
                                    endDate.month,
                                    endDate.day,
                                    endTime.hour,
                                    endTime.minute,
                                    0,
                                  );
                                  if (endDate.isBefore(startDate)) {
                                    startDate = endDate.subtract(difference);
                                    startTime = TimeOfDay(
                                      hour: startDate.hour,
                                      minute: startDate.minute,
                                    );
                                  }
                                });
                              }
                            },
                          ),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            leading: Icon(Icons.public, color: Colors.black87),
            title: Text(timeZoneCollection[selectedTimeZoneIndex]),
            onTap: () {
              showDialog<Widget>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return TimeZonePicker();
                },
              ).then((dynamic value) => setState(() {}));
            },
          ),
          const Divider(height: 1.0, thickness: 1),
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            leading: Icon(
              Icons.lens,
              color: colorCollection[selectedColorIndex],
            ),
            title: Text(colorNames[selectedColorIndex]),
            onTap: () {
              showDialog<Widget>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return ColorPicker();
                },
              ).then((dynamic value) => setState(() {}));
            },
          ),
          const Divider(height: 1.0, thickness: 1),
          ListTile(
            contentPadding: const EdgeInsets.all(5),
            leading: Icon(Icons.subject, color: Colors.black87),
            title: TextField(
              controller: TextEditingController(text: notes),
              onChanged: (String value) {
                notes = value;
              },
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Add description',
              ),
            ),
          ),
          const Divider(height: 1.0, thickness: 1),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(getTitle()),
          backgroundColor: colorCollection[selectedColorIndex],
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              icon: const Icon(Icons.done, color: Colors.white),
              onPressed: () {
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                final List<Meeting> meetings = <Meeting>[];
                if (selectedAppointment != null) {
                  events.appointments?.removeAt(
                    events.appointments!.indexOf(selectedAppointment),
                  );
                  events.notifyListeners(
                    CalendarDataSourceAction.remove,
                    <Meeting>[selectedAppointment!],
                  );
                }
                meetings.add(
                  Meeting(
                    from: startDate,
                    to: endDate,
                    background: colorCollection[selectedColorIndex],
                    startTimeZone:
                        selectedTimeZoneIndex == 0
                            ? ''
                            : timeZoneCollection[selectedTimeZoneIndex],
                    endTimeZone:
                        selectedTimeZoneIndex == 0
                            ? ''
                            : timeZoneCollection[selectedTimeZoneIndex],
                    description: notes,
                    isAllDay: isAllDay,
                    eventName: subject == '' ? '(No title)' : subject,
                  ),
                );
                final dbRef = FirebaseDatabase.instance.ref().child(
                  "CalendarData",
                );
                dbRef
                    .push()
                    .set({
                      "StartTime": startDate.toString(),
                      "EndTime": endDate.toString(),
                      "Subject": subject,
                    })
                    .then((_) {
                      if (mounted) {
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(content: Text('Successfully Added')),
                        );
                      }
                    })
                    .catchError((onError) {
                      log(onError.toString());
                    });

                events.appointments!.add(meetings[0]);

                events.notifyListeners(CalendarDataSourceAction.add, meetings);
                selectedAppointment = null;

                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: Stack(children: <Widget>[_getAppointmentEditor(context)]),
        ),
        floatingActionButton:
            selectedAppointment == null
                ? const Text('')
                : FloatingActionButton(
                  onPressed: () {
                    if (selectedAppointment != null) {
                      events.appointments?.removeAt(
                        events.appointments!.indexOf(selectedAppointment),
                      );
                      events.notifyListeners(
                        CalendarDataSourceAction.remove,
                        <Meeting>[selectedAppointment!],
                      );
                      selectedAppointment = null;
                      Navigator.pop(context);
                    }
                  },
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.delete_outline, color: Colors.white),
                ),
      ),
    );
  }

  String getTitle() {
    return subject.isEmpty ? 'New event' : 'Event details';
  }
}
