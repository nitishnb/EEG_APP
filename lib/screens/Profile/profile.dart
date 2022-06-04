import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stress_detection_app/models/user.dart';
import 'package:stress_detection_app/screens/Profile/edit_profile_page.dart';
import 'package:stress_detection_app/services/database.dart';
import 'package:stress_detection_app/shared/loading.dart';
import 'package:stress_detection_app/widget/button_widget.dart';
import 'package:stress_detection_app/widget/numbers_widget.dart';
import 'package:stress_detection_app/widget/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user1 = Provider.of<User>(context);
    // final user = DatabaseService(uid: user1.uid).userData;

    return Builder(
      builder: (context) =>
          Scaffold(
            body: StreamBuilder<Info>(
                stream: DatabaseService(uid: user1.uid).userData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Info? userData = snapshot.data;
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        const SizedBox(height: 35),
                        ProfileWidget(
                          imagePath: userData!.profilePic,
                          onClicked: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) =>
                                  EditProfilePage()),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        buildName(userData),
                        const SizedBox(height: 24),
                        NumbersWidget(userData),
                        const SizedBox(height: 24),
                        Center(child: buildUpgradeButton()),
                        const SizedBox(height: 102),
                        Image.network('https://api.parashospitals.com/uploads/2017/10/BMI.png',width: 180, height: 180),
                        // buildAbout(user),
                      ],
                    );
                  } else {
                    return Loading();
                  }
                }
            ),
          ),
    );
  }

  Widget buildName(Info user) =>
      Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.emailid,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() =>
      ButtonWidget(
        text: 'EDIT  📝',
        onClicked: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) =>
                EditProfilePage()),
          );
        },
      );

  Widget buildAbout(Info user) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.uid,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}