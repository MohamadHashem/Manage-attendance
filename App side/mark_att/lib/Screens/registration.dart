import 'package:connectivity/connectivity.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:mark_att/Screens/login.dart';

import 'package:mark_att/widgets/ProgressDialog.dart';
import 'package:mark_att/widgets/TaxiButton.dart';

class RegistrationPage extends StatefulWidget {
  static const String id ='register';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey =new GlobalKey<ScaffoldState>();

  void showSnackBar(String title){
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  final FirebaseAuth _auth= FirebaseAuth.instance;
  var fullNameController=TextEditingController();
  var phoneController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  void registerUser() async {
    //show dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>ProgressDialog(status: 'REGISTERING',),
    );

    final auth.User  user =(await _auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ).catchError((ex){
      //check error and display message
      Navigator.pop(context);
      PlatformException thisEX=ex;
      showSnackBar(thisEX.message);
    })).user;
    Navigator.pop(context);
    //check if the user registration is succefull
    if(user != null){
      DatabaseReference newUserREf =FirebaseDatabase.instance.reference().child('users/${user.uid}');
      //prepare data to be saved  on users table
      Map userMap ={
        'fullname':fullNameController.text,
        'email':emailController.text,


      };
      newUserREf.set(userMap);
      // currentFirebaseUser =user;
      //take user to vehicle info page
      Navigator.pushNamed(context, LoginPage.id);
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
              SizedBox(height: 50,),
              Image(
                alignment: Alignment.center,
                height: 150.0,
                width: 300.0,
                image: AssetImage('images/reg_icon.png'),
              ),
              SizedBox(height: 30,),
              Text('Create  Account',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontFamily: 'Brand-bold'),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    //full name
                    TextField(
                      controller: fullNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
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
                    //email
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
                    // SizedBox(height: 10,),
                    // //phone
                    // TextField(
                    //   controller: phoneController,
                    //   keyboardType: TextInputType.phone,
                    //   decoration: InputDecoration(
                    //     labelText: 'Phone Number',
                    //     labelStyle: TextStyle(
                    //       fontSize: 14.0,
                    //     ),
                    //     hintStyle: TextStyle(
                    //       color: Colors.grey,
                    //       fontSize: 10.0,
                    //     ),
                    //   ),
                    //   style: TextStyle(fontSize: 14),
                    // ),
                    SizedBox(height: 10,),

                    //password
                    TextField(
                      controller: passwordController,
                      obscureText: debugInstrumentationEnabled,
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
                      title:'REGISTER',
                      color: Colors.black,
                      onPressed:() async{

                        //check network availablity
                        var connectivityResult = await Connectivity().checkConnectivity();
                        if(connectivityResult !=ConnectivityResult.mobile && connectivityResult !=ConnectivityResult.wifi){
                          showSnackBar('No internet connection');
                          return;
                        }

                        if(fullNameController.text.length <3){
                          showSnackBar('please provide a valid full name');
                          return;
                        }
                        // if(phoneController.text.length <8){
                        //   showSnackBar('please provide a valid phone number');
                        //   return;
                        // }
                        if(!emailController.text.contains('@')){
                          showSnackBar('please provide a valid Email Address');
                          return;
                        }
                        if(passwordController.text.length <8){
                          showSnackBar('password must be at least 8 characters!');
                          return;
                        }
                        registerUser();
                      },
                    )
                  ],
                ),
              ),
              FlatButton(
                  onPressed: (){
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) => new LoginPage())
                    );                  },
                  child: Text('LOG IN',style: TextStyle(fontSize: 20, fontFamily: 'Brand-bold',color:Colors.blue),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
