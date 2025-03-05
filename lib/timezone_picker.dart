import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';

class TimeZonePicker extends StatefulWidget {
  const TimeZonePicker({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TimeZonePickerState();
  }
}

class _TimeZonePickerState extends State<TimeZonePicker> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: timeZoneCollection.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: Icon(
                index == selectedTimeZoneIndex
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
              ),
              title: Text(timeZoneCollection[index]),
              onTap: () {
                setState(() {
                  selectedTimeZoneIndex = index;
                });

                final navigator = Navigator.of(context);

                // ignore: always_specify_types
                Future.delayed(const Duration(milliseconds: 200), () {
                  // When task is over, close the dialog
                  if (navigator.mounted) {
                    navigator.pop();
                  }
                });
              },
            );
          },
        ),
      ),
    );
  }
}
