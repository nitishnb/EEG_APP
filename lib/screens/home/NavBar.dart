import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stress_detection_app/models/user.dart';
import 'package:stress_detection_app/services/auth.dart';
import 'package:stress_detection_app/services/database.dart';
import 'package:stress_detection_app/shared/loading.dart';

class NavBar extends StatelessWidget {
  final AuthService _auth = AuthService();

  showAlertDialog(BuildContext context) {
    print(_auth.user);
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Logout",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      onPressed:  () async {
        await _auth.signOut();
        _auth.signOutGoogle();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          StreamBuilder<Info>(
              stream: DatabaseService(uid: user.uid).userData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Info? userData = snapshot.data;
                  return Column(
                    children: <Widget>[
                      userData!.profilePic == "" ?
                      UserAccountsDrawerHeader(
                          accountName: Text(userData.name),
                          accountEmail: Text(userData.emailid),
                          currentAccountPicture: Icon(Icons.account_circle, size: 90,
                          color: Colors.white,
                          )
                      ):
                      UserAccountsDrawerHeader(
                        accountName: Text(userData.name),
                        accountEmail: Text(userData.emailid),
                        currentAccountPicture: CircleAvatar(
                          child: ClipOval(
                            child: Image.network(
                              userData.profilePic,
                              fit: BoxFit.cover,
                              width: 90,
                              height: 90,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Loading();
                }
              }
          ),
          ListTile(
            leading: Icon(Icons.analytics_outlined),
            title: Text('Analysis'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text('Profile'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Policies'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            title: Text('LogOut'),
            leading: Icon(Icons.exit_to_app),
            onTap: () async {
              showAlertDialog(context);
            },
          ),
        ],
      ),
    );
  }
}