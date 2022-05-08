import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stress_detection_app/services/auth.dart';
import 'package:stress_detection_app/shared/loading.dart';

class SignupPage extends StatefulWidget {

  final Function toggleView;
  SignupPage({ required this.toggleView });

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<SignupPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  // String name = '';
  // String phoneNumber = '';
  String password = '';
  String confirmPassword = '';
  String error = '';
  String profile_pic='';

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('GreenKey',textAlign: TextAlign.center,style: TextStyle(fontSize: 32),),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.lightGreen,
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
                key: _formKey,
                child: ListView(
                children: <Widget>[
                  Icon(
                    Icons.assignment_ind,
                    size: 140,
                    color: Colors.lightGreen,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 0,bottom: 30),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'fonts/IndieFlower-Regular.ttf',
                            fontSize: 50),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 2),
                    child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Colors.lightGreen)),
                          fillColor: Colors.lightGreen[200],
                          filled: true,
                          labelText: 'Email :',
                          labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                        ),
                        validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                        onChanged: (val){
                          setState(() => email = val);
                        }
                    ),
                  ),
                  // SizedBox(height: 20.0),
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(10, 0, 10, 2),
                  //   child: TextFormField(
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Colors.lightGreen)),
                  //       fillColor: Colors.lightGreen[200],
                  //       filled: true,
                  //       labelText: 'Name :',
                  //       labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                  //     ),
                  //     validator: (val) => val!.length < 1 ? 'Enter name' : null,
                  //     onChanged: (val){
                  //       setState(() => name = val);
                  //     },
                  //   ),
                  // ),
                  // SizedBox(height: 20.0),
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(10, 0, 10, 2),
                  //   child: TextFormField(
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Colors.lightGreen)),
                  //       fillColor: Colors.lightGreen[200],
                  //       filled: true,
                  //       labelText: 'Phone Number :',
                  //       labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                  //     ),
                  //     validator: (val) => val!.length == 10 ? null : 'Enter 10 digit phone number' ,
                  //     onChanged: (val){
                  //       setState(() => phoneNumber = val);
                  //     },
                  //   ),
                  // ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 2),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Colors.lightGreen)),
                        fillColor: Colors.lightGreen[200],
                        filled: true,
                        labelText: 'Password :',
                        labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => val!.length <6 ? 'Enter a password 6+ chars long' : null,
                      onChanged: (val){
                        setState(() => password = val);
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                 Container(
                   padding: EdgeInsets.fromLTRB(10, 0, 10, 2),
                   child: TextFormField(
                     obscureText: true,
                     decoration: InputDecoration(
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Colors.lightGreen)),
                       fillColor: Colors.lightGreen[200],
                       filled: true,
                       labelText: ' Confirm Password :',
                       labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                     ),
                     validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                      onChanged: (val){
                        setState(() => confirmPassword = val);
                      },
                   ),
                 ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.lightGreen,
                        child: Text('SignUP',style: TextStyle(fontSize: 24),),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()){
                            setState(() => loading = true);
                            if(password == confirmPassword){
                              dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                              if(result == null){
                                setState(() {
                                  error = 'Please supply a valid email';
                                  loading = false;
                                });
                              }
                            }
                            else{
                              setState(() {
                                  error = 'Passwords does not match';
                                  loading = false;
                                });
                            }
                          }
                        },
                      )),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  Container(
                      child: Row(
                        children: <Widget>[
                          Text('Have an existing account?'),
                          FlatButton(
                            textColor: Colors.lightGreen,
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              widget.toggleView();
                            },
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
