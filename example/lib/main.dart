import 'package:custom_calendar/custom_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: GestureDetector(
          onTap: () => CustomCalendar(context),
          child: Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: StreamBuilder<List<DateTime>>(
                stream: selectedDates,
                builder: (context, snapshot) {
                  if (snapshot != null && snapshot.hasData) {
                    final text = dateFormat(snapshot);
                    return Text(text);
                  }
                  return const Text('Выберите дату');
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  String dateFormat(AsyncSnapshot snapshot) {
    if (snapshot.data.length == 1) {
      return DateFormat.yMd('ru').format(snapshot.data.first);
    }
    return '${DateFormat.yMd('ru').format(snapshot.data.first)} - ${DateFormat.yMd('ru').format(snapshot.data.last)}';
  }

  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
  }
}
