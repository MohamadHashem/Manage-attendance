import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mark_att/Screens/students.dart';

class Dates extends StatefulWidget {
  static const String id ='dates';


  final course;

  const Dates({Key key, this.course}) : super(key: key);
  @override
  _DatesState createState() => _DatesState();
}

class _DatesState extends State<Dates> {
  Query _ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('Attendance').child('${widget.course}')
    // .orderByChild('name')
        ;
  }

  @override
  Widget build(BuildContext context) {
    var lists = [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('List of dates'),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.refresh),
        //     onPressed: () {
        //
        //       Navigator.push(context, new MaterialPageRoute(
        //           builder: (context) => new Dates())
        //       );
        //
        //     },
        //
        //   )
        // ],
      ),
      body: Container(
          height: double.infinity,
          child: FutureBuilder(
              future: _ref.once(),
              builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                if (snapshot.hasData) {
                  lists.clear();
                  Map<dynamic, dynamic> values = snapshot.data.value;
                  values.forEach((key, values) {
                    lists.add(values);
                  });
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: values.length,
                      itemBuilder: (BuildContext context, int index) {
                        String key = values.keys.elementAt(index);
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  Students(dates: '$key', course: widget.course,)),
                            );
                          },
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height:40,),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (_) {
      //         return AddContacts();
      //       }),
      //     );
      //   },
      //   child: Icon(Icons.add, color: Colors.white),
      // ),
    );
  }
}
