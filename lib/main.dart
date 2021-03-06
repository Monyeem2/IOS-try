import 'package:flutter/material.dart';
import 'package:msgr_app/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:msgr_app/try.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Splashpage(),
      //home:  Chatting('6PkeIbQ94tayqHJZOofjGuhm6mD2', 'receiverImage', '0q4oXixvj2brFNdb7XH7tp8u2bI2', '0q4oXixvj2brFNdb7XH7tp8u2bI2', 'userEmail', 'receiverEmail', 'userImage'),
    );
  }
}
