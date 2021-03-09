import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/records_screen.dart';
import 'providers/record.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecordProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {'/': (ctx) => RecordsScreen()},
      ),
    );
  }
}
