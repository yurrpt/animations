import 'package:flutter/material.dart';

import 'example2/example2.dart';
import 'example3/example3.dart';
import 'example4/example4.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        darkTheme: ThemeData(brightness: Brightness.dark),
        home: const ExampleFour());
  }
}
