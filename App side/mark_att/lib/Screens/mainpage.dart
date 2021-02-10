import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:mark_att/Screens/about.dart';
import 'package:mark_att/Screens/dates.dart';
import 'package:mark_att/Screens/login.dart';
import 'package:mark_att/Screens/profile.dart';
import 'package:mark_att/styles/styles.dart';
import 'package:mark_att/widgets/BrandDivier.dart';
import 'package:outline_material_icons/outline_material_icons.dart';


class MainPage extends StatefulWidget {
  static const String id ='mainpage';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>  {
  Query _ref;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('Attendance')
        // .orderByChild('name')
    ;
  }

  Widget _buildContactItem({Map contact}) {
    // Color typeColor = getTypeColor(contact['type']);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      height: 100,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                contact[''],
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
    //       // Row(
    //       //   children: [
    //       //     Icon(
    //       //       Icons.phone_iphone,
    //       //       color: Theme.of(context).accentColor,
    //       //       size: 20,
    //       //     ),
    //       //     SizedBox(
    //       //       width: 6,
    //       //     ),
    //       //     Text(
    //       //       contact['email'],
    //       //       style: TextStyle(
    //       //           fontSize: 16,
    //       //           color: Theme.of(context).accentColor,
    //       //           fontWeight: FontWeight.w600),
    //       //     ),
    //       //     SizedBox(width: 15),
    //       //     Icon(
    //       //       Icons.group_work,
    //       //       color: Colors.black,
    //       //       // color: typeColor,
    //       //       size: 20,
    //       //     ),
    //       //     SizedBox(
    //       //       width: 6,
    //       //     ),
    //           // Text(
    //           //   contact['type'],
    //           //   style: TextStyle(
    //           //       fontSize: 16,
    //           //       color: typeColor,
    //           //       fontWeight: FontWeight.w600),
    //           // ),
    //         ],
    //       ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lists=[];
    return Scaffold(
      drawer: Container(
          width: 250,
          color: Colors.white,
          child: Drawer(


            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                Container(
                  color: Colors.white,
                  height: 160,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    child: Row(
                      children: <Widget>[
                        Image.asset('images/att_icon.png',height: 60,width: 60,),
                        SizedBox(width: 15,),


                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Senior',style: TextStyle(fontSize: 20,fontFamily: 'Brand-Bold'),),
                            SizedBox(height: 5,),
                            Text('Attendance App'),
                            


                          ],
                          
                        )
                        

                      ],
                    ),

                  ),
                ),
                BrandDivider(),
                SizedBox(height: 10,),
              
                ListTile(
                  onTap: (){
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) => new Profile())
                    );
                  },
                  leading: Icon(OMIcons.accountCircle),
                  title: Text('Profile',style:kDrawerItemStyle,),

                ),
                ListTile(
                          onTap: (){
                           Navigator.push(context, new MaterialPageRoute(
                          builder: (context) => new About())
                    );
                    },
                  leading: Icon(OMIcons.info),
                  title: Text('About',style:kDrawerItemStyle,),
                ),
                BrandDivider(),
                SizedBox(height: 40,),
                ListTile(
                  onTap: (){
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) => new LoginPage())
                    );
                  },
                  leading: Icon(OMIcons.arrowBackIos),
                  title: Text('Log out',style:kDrawerItemStyle,),

                ),

              ],

            ),


          ),

      ),


      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('List of class'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {

              Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => new MainPage())
              );
              
              },

          )
        ],
      ),


      body: Container(
        height: double.infinity,
        child:  FutureBuilder(
            future: _ref.once(),
            builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
              if (snapshot.hasData) {
                lists.clear();
                Map<dynamic, dynamic> values = snapshot.data.value;
                values.forEach((key, values) {
                  lists.add(values);
                });
                return  ListView.builder(
                    shrinkWrap: true,
                    itemCount: values.length,
                    itemBuilder: (BuildContext context, int index) {
                      String key = values.keys.elementAt(index);
                      return InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Dates(course: '$key',)),
                          );
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 40,),
                              Text('$key',
                              textAlign: TextAlign.center,
                               style: TextStyle(fontSize: 25,
                               fontFamily: 'Brand-bold'),
                               ),

                            ],
                          ),
                        ),
                      );
                    });
              }
              return CircularProgressIndicator();
            })
      ),

    );
  }


}