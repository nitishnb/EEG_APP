import 'package:stress_detection_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:stress_detection_app/services/auth.dart';
import 'package:stress_detection_app/shared/loading.dart';
import 'package:stress_detection_app/screens/authenticate/forgotpassword.dart';

class LoginPage extends StatefulWidget {

  final Function toggleView;
  LoginPage({ required this.toggleView });

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';


  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Reliever',textAlign: TextAlign.center,style: TextStyle(fontSize: 32,color: Colors.blue),),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
                key: _formKey,
                child: ListView(
                children: <Widget>[
                  SizedBox(height: 40.0),
                  Icon(
                    Icons.bubble_chart,
                    size: 140,
                    color: Colors.white,
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                          fillColor: Colors.lightBlue[200],
                          filled: true,
                          labelText: 'User Name/ Email',
                          labelStyle: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.bold),
                        ),
                        validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                        onChanged: (val){
                          setState(() => email = val);
                        }
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        fillColor: Colors.lightBlue[200],
                        filled: true,
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => val!.length <6 ? 'Enter a password 6+ chars long' : null,
                      onChanged: (val){
                        setState(() => password = val);
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.lightBlue,
                        color: Colors.white,
                        child: Text('Login',style: TextStyle(fontSize: 24),),
                        onPressed: () async {
                            if (_formKey.currentState!.validate()){
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                              if(result == null){
                                setState(() {
                                  error =
                                  'Could Not SignIn With Those credentials';
                                  loading = false;
                                });
                              }
                            }
                        },
                      ),
                  ),
                  SizedBox(height: 15.0),
                  FlatButton(
                    onPressed: (){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => ForgotPassword()),
                        );  //forgot password screen
                    },
                    textColor: Colors.white,
                    child: Text('Forgot Password..?',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  SizedBox(height: 15.0,),
                  //Divider(height: 10.0, color: Colors.green[700],),
                  RaisedButton(
                    splashColor: Colors.black,
                    textColor: Colors.white,
                    color: Colors.white,
                    onPressed: () async {
                      _auth.signInWithGoogle().whenComplete(() => {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => MyHomePage()))
                      });
                      setState(() {
                        loading = true;
                      });
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    highlightElevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(image: NetworkImage('https://assets.stickpng.com/images/5847f9cbcef1014c0b5e48c8.png'), height: 20.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Sign in with Google',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  Container(
                      child: Row(
                        children: <Widget>[
                          Text("Don't have account?"),
                          FlatButton(
                            textColor: Colors.white,

                            onPressed: () {
                              widget.toggleView();
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ))
                ],
            )
          )
        )
    );
  }
}