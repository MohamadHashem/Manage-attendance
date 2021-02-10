import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Students extends StatefulWidget {
  static const String id ='students';

  final dates;
  final course;

  const Students({Key key, this.dates, this.course}) : super(key: key);
  @override
  _StudentsState createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  Query _ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('Attendance').child('${widget.course}').child('${widget.dates}')
    // .orderByChild('name')
        ;
  }


  @override
  Widget build(BuildContext context) {
    var lists = [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('List of Students'),
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
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  Times(student: '$key', course: widget.course, dates: widget.dates,)),
                            );
                          },
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 40,),
                                Icon(
                                  Icons.person,
                                  color: Theme.of(context).primaryColor,
                                  size: 30,
                                ),
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
class Times extends StatefulWidget {
  final course;
  final student;
  final dates;

  const Times({Key key, this.course, this.student, this.dates}) : super(key: key);
  @override
  _TimesState createState() => _TimesState();
}

class _TimesState extends State<Times> {
  Query _ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('Attendance').child('${widget.course}').child('${widget.dates}').child('${widget.student}')
    // .orderByChild('name')
        ;
  }


  @override
  Widget build(BuildContext context) {
    var lists = [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('List of Times  '),
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
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 30,),

                              Text('${lists[index]['name']}',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25,
                                fontFamily: 'Brand-bold'),
                                ),
                              Text('${lists[index]['time']}',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25,
                                fontFamily: 'Brand-bold'),
                                ),
                            ],
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
