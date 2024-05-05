import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/firebase_options.dart';
import 'package:furniture_app/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  //jasser
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter furniture App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
