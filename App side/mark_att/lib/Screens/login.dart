import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mark_att/Screens/mainpage.dart';
import 'package:mark_att/Screens/registration.dart';

import 'package:mark_att/widgets/ProgressDialog.dart';
import 'package:mark_att/widgets/TaxiButton.dart';

class  LoginPage extends StatefulWidget {
  static const String id ='login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey =new GlobalKey<ScaffoldState>();

  void showSnackBar(String title){
    final snackbar = SnackBar(
      content: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 15),),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
  static const String id ='login';
  final FirebaseAuth _auth =FirebaseAuth.instance;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  void login() async{

    //show dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>ProgressDialog(status: 'Logging in',),
    );


    final auth.User user =(await _auth.signInWithEmailAndPassword(
      email:emailController.text,
      password: passwordController.text,
    ).catchError((ex){
      //check error and display message
      Navigator.pop(context);
      PlatformException thisEX=ex;
      showSnackBar(thisEX.message);

    })).user;
    if(user !=null){
      //verify login
      DatabaseReference userRef =FirebaseDatabase.instance.reference().child('users/${user.uid}');
      userRef.once().then((DataSnapshot snapshot)  {
        if(snapshot.value !=null){
          Navigator.push(context, new MaterialPageRoute(
              builder: (context) => new MainPage())
          );        }

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 70,),
              Image(
                alignment: Alignment.center,
                height: 200.0,
                width: 200.0,
                image: AssetImage('images/login1.png'),
              ),
              SizedBox(height: 40,),
              Text('Sign Into Your Account',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontFamily: 'Brand-bold'),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 40,),
                    TaxiButton(
                      title:'LOGIN',
                      color: Colors.black,
                      onPressed:() async{
                        //check network availablity
                        var connectivityResult = await Connectivity().checkConnectivity();
                        if(connectivityResult !=ConnectivityResult.mobile && connectivityResult !=ConnectivityResult.wifi){
                          showSnackBar('No internet connection');
                          return;
                        }
                        if(!emailController.text.contains('@')){
                          showSnackBar('please provide a valid Email Address');
                          return;
                        }
                        if(passwordController.text.length <8){
                          showSnackBar('invalid password.Make sure to enter correct password!');
                          return;
                        }
                        login();
                      },
                    ),

                  ],
                ),
              ),
              FlatButton(
                  onPressed: (){
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) => new RegistrationPage())
                    );                  },

                          child: Text( 'SIGN UP ',style: TextStyle(fontSize: 20, fontFamily: 'Brand-bold',color:Colors.blue),),

              ),
            ],
          ),
        ),
      ),
    );
  }
}

