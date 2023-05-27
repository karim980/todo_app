import 'package:flutter/material.dart';

class DateScreen extends StatefulWidget {
  const DateScreen({Key? key}) : super(key: key);

  @override
  State<DateScreen> createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  DateTime selectedDate = DateTime.now();


  Future<void> _selectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(initialDatePickerMode: DatePickerMode.year,
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Date"),

      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)),
              onPressed: () =>  _selectDate(context), child: Text('Date Picker',style: TextStyle(fontSize: 40),),
            ),
            Text('data time = ${selectedDate.year}/${selectedDate.month}/${selectedDate.day}'),
          ],
        ),
      ) ,
    );
  }
}
