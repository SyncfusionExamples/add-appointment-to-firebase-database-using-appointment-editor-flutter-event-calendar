import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ColorPickerState();
  }
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: colorCollection.length - 1,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: Icon(
                index == selectedColorIndex ? Icons.lens : Icons.trip_origin,
                color: colorCollection[index],
              ),
              title: Text(colorNames[index]),
              onTap: () {
                setState(() {
                  selectedColorIndex = index;
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
