//
// import 'package:flutter/material.dart';
// import 'dart:async';
//
// import 'package:mark_att/Screens/login.dart';
//
// // void main() => runApp(new Splash());
//
// class Splash extends StatelessWidget {
//   static const String id ='splash';
//   @override
//   State<StatefulWidget> createState() {
//     return _SplashScreenState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
//
// }
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 10), () {
//       navigateUser(); //It will redirect  after 3 seconds
//     });
//   }
//   void navigateUser() async{
//
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
//     // }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//           children: <Widget>[
//             Container(
//               color: Colors.white,
//             ),
//             Center(
//               child: Column(
//                 children: <Widget>[
//                   Expanded(
//                     flex: 1,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         CircleAvatar(
//                           backgroundColor: Colors.white,
//                           radius: 50.0,
//                           child: Image(
//                             image: AssetImage('images/splashlogo.png'),
//                             alignment: Alignment.center,
//                             height: 400.0,
//                             width: 400.0,
//                             // size: 48.0,
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(top: 16),
//                           child: Text(
//                             'Welcome',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 32,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   CircularProgressIndicator(),
//                   Padding(
//                     padding: EdgeInsets.only(top: 16,bottom: 32),
//                     child: Text(
//                       'Loding',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 24,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ));
//   }
// }