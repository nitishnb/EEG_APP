import 'package:flutter/material.dart';
import 'package:stress_detection_app/services/auth.dart';
import 'package:stress_detection_app/shared/loading.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  String email = '';
  String password = '';
  String error = '';
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.lightGreen,
        appBar: AppBar(
          centerTitle: true,
          title: Text('GreenKey',textAlign: TextAlign.center,style: TextStyle(fontSize: 32,color: Colors.lightGreen),),
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
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                          fillColor: Colors.lightGreen[200],
                          filled: true,
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                        ),
                        validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                        onChanged: (val){
                          setState(() => email = val);
                        }
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.lightGreen,
                        color: Colors.white,
                        child: Text('Reset',style: TextStyle(fontSize: 24),),
                        onPressed: () async {
                            if (_formKey.currentState!.validate()){
                                setState(() {
                                  loading = true;
                                });
                                try{
                                  await _auth.sendPasswordResetEmail(email);
                                  setState(() => error = 'Email sent succefully');
                                }catch(e){
                                  print(e.toString());
                                  setState(() => error = 'User Not Found');
                                }
                                setState(() {
                                  loading = false;
                                });
                              }
                            }
                      ),
                  ),
                  SizedBox(height: 12.0),
                  FlatButton(
                    onPressed: (){
                        Navigator.pop(context);
                         //forgot password screen
                    },
                    textColor: Colors.white,
                    child: Text('Back',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.green[900], fontSize: 14.0),
                  ),
                ],
            )
          )
        )
    );
  }
}