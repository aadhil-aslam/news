import 'package:flutter/material.dart';
import 'package:flutternews/views/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'News',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
