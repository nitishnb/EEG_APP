import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stress_detection_app/models/user.dart';
import 'package:stress_detection_app/screens/Profile/profile.dart';
import 'package:stress_detection_app/screens/analysis/LineChart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:stress_detection_app/services/database.dart';
import 'package:stress_detection_app/shared/loading.dart';
import 'package:stress_detection_app/services/auth.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthService _auth = AuthService();
  TooltipBehavior? _tooltipBehavior;
  String _selectedBodyTitle = "Reliever";
  int _selectedIndex = 0;
  dynamic _selectedBody = Home();

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        drawer:  Drawer(
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
                selected: _selectedIndex == 0,
                leading: Icon(Icons.home_outlined),
                title: Text('Home'),
                onTap: () => {
                  setState(() {
                    _selectedIndex = 0;
                    _selectedBody = Home();
                    _selectedBodyTitle = "Reliever";
                  }),
                  Navigator.of(context).pop(),
                },
              ),
              ListTile(
                selected: _selectedIndex == 1,
                leading: Icon(Icons.analytics_outlined),
                title: Text('Analysis'),
                onTap: () => {
                  setState(() {
                    _selectedIndex = 1;
                    _selectedBody = LineChart();
                    _selectedBodyTitle = "Stress Graph";
                  }),
                  Navigator.of(context).pop(),
                },
              ),
              ListTile(
                selected: _selectedIndex == 2,
                leading: Icon(Icons.account_circle_outlined),
                title: Text('Profile'),
                onTap: () => {
                  setState(() {
                    _selectedIndex = 2;
                    _selectedBody = Profile();
                    _selectedBodyTitle = "Profile";
                  }),
                  Navigator.of(context).pop(),
                },
              ),
              ListTile(
                selected: _selectedIndex == 3,
                leading: Icon(Icons.share),
                title: Text('Share'),
                onTap: () => {
                  setState(() {
                    _selectedIndex = 3;
                    _selectedBody = Home();
                    _selectedBodyTitle = "Share";
                  }),
                  Navigator.of(context).pop(),
                },
              ),
              Divider(),
              ListTile(
                selected: _selectedIndex == 4,
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () => {
                  setState(() {
                    _selectedIndex = 4;
                    _selectedBody = Home();
                    _selectedBodyTitle = "Settings";
                  }),
                  Navigator.of(context).pop(),
                },
              ),
              ListTile(
                selected: _selectedIndex == 5,
                leading: Icon(Icons.description),
                title: Text('Policies'),
                onTap: () => {
                  setState(() {
                    _selectedIndex = 5;
                    _selectedBody = Home();
                    _selectedBodyTitle = "Policies";
                  }),
                  Navigator.of(context).pop(),
                },
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
        ),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(_selectedBodyTitle),
        ),
        body: _selectedBody // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Welcome"),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Settings"),
    );
  }
}
