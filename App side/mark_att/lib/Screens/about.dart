import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';



class About extends StatefulWidget {
    static const String id ='about';
  @override
  _AboutState createState() => _AboutState();

}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:Text('About',textAlign: TextAlign.center),

      ),
      body:Center(
        child:ListView (
            shrinkWrap: true,
          children: [
            Center(
              child: Card(
                child: Column(
                  // width: 170,
                  // height: 300,

                  children: [
                    SizedBox(height: 10,),

                    CircleAvatar(
                      backgroundImage: ExactAssetImage('images/att_icon.png'),
                      minRadius: 20,
                      maxRadius: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Matt',
                        textScaleFactor: 3,
                        style:TextStyle( color: Colors.red,) ,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text('MATT is first mobile application in Lebanon that combines'
                          ' artificial intelligence with a flutter mobile application.'
                          ' Also, MATT is the first senior project in PU that holds artificial intelligence with flutter.',



                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 100,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],

                ),
              ),
            ),

            Center(
              child: Card(

                child: Column(
                  // width: 170,
                  // height: 300,

                  children: [
                    SizedBox(height: 25,),
                    CircleAvatar(

                      backgroundImage: ExactAssetImage('images/mohamad.jpeg'),
                      minRadius: 60,
                      maxRadius: 100,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'MOHAMAD  HASHEM',
                        textScaleFactor: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'CS STUDENT',
                        textAlign: TextAlign.center,
                        textScaleFactor: 2,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        style: TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(10.0),
                    //   child:IconButton(
                    //     onPressed: () => launch('https://www.facebook.com/mohamad.hashem.376'),
                    //       icon: Image.asset("images/fb.png",fit:BoxFit.fill,),
                    //
                    // ),
                    // )
                  ],
                ),
              ),
            ),

            Center(
                child: Card(
                  child: Column(
                    // width: 170,
                    // height: 300,

                    children: [
                      SizedBox(height: 25,),

                      CircleAvatar(
                        backgroundImage: ExactAssetImage('images/hassan.jpg'),
                        minRadius: 60,
                        maxRadius: 100,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          '     HASSAN KHALIL     ',
                          textScaleFactor: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'CS STUDENT',
                          textAlign: TextAlign.center,
                          textScaleFactor: 2,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                          style: TextStyle(
                            color: Colors.red,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.all(10.0),
                      //   child:IconButton(
                      //     icon: Image.asset("images/fb.png",fit:BoxFit.fill,),
                      //     onPressed: () => setState(() {
                      //
                      //     }
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),

          ],
          )
        ),
      );
  }
}