import 'package:calendar/events_with_calander.dart';
import 'package:calendar/utils.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class new_event extends StatefulWidget {
  DateTime date;
  new_event({super.key, required this.date});

  @override
  State<StatefulWidget> createState() => _State(date);
}

class _State extends State<new_event> {
  DateTime date;
  _State(this.date);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String Title = "";
  String Note = "";
  TimeOfDay _selectedTime1 = TimeOfDay.now();
  TimeOfDay _selectedTime2 = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Form(
      key: _formkey,
      child: Container(
        margin: const EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                formatDate(date, [yyyy, '-', mm, '-', dd]),
                style:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Title",
                ),
                validator: (text) {
                  if (text.toString().isEmpty) {
                    return 'Title cannot be empty';
                  }
                },
                onSaved: (text) {
                  Title = text.toString();
                }),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    _selectTime(context, 1);
                  },
                  child: const Text(
                    "Set event start time - ",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Text(
                  DateFormat.jm().format(DateTime(
                      2000, 1, 1, _selectedTime2.hour, _selectedTime2.minute)),
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    _selectTime(context, 2);
                  },
                  child: const Text(
                    "Set event end time - ",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Text(
                  DateFormat.jm().format(DateTime(
                      2000, 1, 1, _selectedTime1.hour, _selectedTime1.minute)),
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
            TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Note",
                ),
                validator: (text) {
                  if (text.toString().isEmpty) {
                    return 'Note cannot be empty';
                  }
                },
                onSaved: (text) {
                  Note = text.toString();
                }),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              child: const Text(
                'Add Event',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                _formkey.currentState!.save();
                if (_formkey.currentState!.validate()) {
                  print("${Title} ${Note}");
                  func(date, Title, Note, _selectedTime1, _selectedTime2);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => events_with_calander()));
                } else {
                  Title = "";
                  Note = "";
                }
              },
            ),
          ],
        ),
      ),
    )));
  }

  Future<void> _selectTime(BuildContext context, int selector) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        if (selector == 1) {
          _selectedTime1 = selectedTime;
        } else if (selector == 2) {
          _selectedTime2 = selectedTime;
        }
      });
    }
  }
}
