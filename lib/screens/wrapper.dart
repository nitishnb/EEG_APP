import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stress_detection_app/screens/authenticate/authenticate.dart';
import 'package:stress_detection_app/screens/home/home.dart';
import 'package:stress_detection_app/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return either home or authenticate widget
    if(user == null){
      return Authenticate();
    } else {
      print(user.uid);
      return Home();
    }
  }
}