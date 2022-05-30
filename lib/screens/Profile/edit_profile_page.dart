import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stress_detection_app/models/user.dart';
import 'package:stress_detection_app/services/database.dart';
import 'package:stress_detection_app/shared/loading.dart';
import 'package:stress_detection_app/widget/button_widget.dart';
import 'package:stress_detection_app/widget/profile_widget.dart';
import 'package:stress_detection_app/widget/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  String formatDate(DateTime date) => new DateFormat("dd/MM/yyyy").format(date);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Builder(
      builder: (context) => Scaffold(
        body: StreamBuilder<Info>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Info? userData = snapshot.data;
                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  physics: BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 50),
                    ProfileWidget(
                      imagePath: userData!.profilePic,
                      isEdit: true,
                      onClicked: () async {},
                    ),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      label: 'Full Name',
                      text: userData!.name,
                      onChanged: (name) {},
                    ),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      label: 'Email',
                      text: userData!.emailid,
                      onChanged: (email) {},
                    ),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      label: 'Date of Birth',
                      text: formatDate(userData.dob),
                      onChanged: (about) {},
                    ),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      label: 'Weight',
                      text: userData.weight.toString(),
                      onChanged: (email) {},
                    ),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      label: 'Height',
                      text: userData.height.toString(),
                      onChanged: (email) {},
                    ),
                    const SizedBox(height: 20),
                    ButtonWidget(text: "Save", onClicked: () => {
                      Navigator.of(context).pop(),
                    }),
                  ],
                );
              } else {
                return Loading();
              }
            }),
      ),
    );
  }
}
