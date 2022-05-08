import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stress_detection_app/models/user.dart';
import 'package:stress_detection_app/screens/wrapper.dart';
import 'package:stress_detection_app/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}