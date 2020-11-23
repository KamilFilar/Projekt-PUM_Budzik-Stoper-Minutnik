import 'dart:async';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

class Budzik extends StatefulWidget {
  @override
  _Budzik createState() => _Budzik();
}

class _Budzik extends State<Budzik> {
  // Function - go to the new subpage
  Future navigateToSubPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewAlarm()));
  }

  var now = new DateTime.now();
  var actualMonth = new DateFormat.MMM();

  String getDateToOutput() {
    var tommorowDay = DateTime.now().add(new Duration(days: 1)).day;

    String formattedMont = actualMonth.format(now);
    String DateToOutput = tommorowDay.toString() + " " + formattedMont + ".";

    print("Data: " + DateToOutput);
    return DateToOutput;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                child: Container(
                    width: 370,
                    height: 70.0,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 85.0),
                          child: Text(
                            '00:00',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text(
                            getDateToOutput(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 7.0, right: 7.0),
                            child: SizedBox(
                                width: 60,
                                child: Switch(
                                    value: true,
                                    onChanged: (value) {
                                      //Do you things
                                    }))),
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          navigateToSubPage(context);
        },
      ),
    );
  }
}

class NewAlarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Dodaj nowy alarm'),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 25.0,
                            bottom: 10.0,
                            left: 15.0,
                            right: 15.0,
                          ),
                          child: Text(
                            "Godzina",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        NumberPicker.integer(
                            initialValue: 6,
                            minValue: 00,
                            maxValue: 23,
                            listViewWidth: 60.0,
                            onChanged: (val) {})
                      ]),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: 50.0,
                          left: 15.0,
                          right: 15.0,
                        ),
                        child: Text(
                          ":",
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 25.0,
                            bottom: 10.0,
                            left: 15.0,
                            right: 15.0,
                          ),
                          child: Text(
                            "Minuta",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        NumberPicker.integer(
                            initialValue: 30,
                            minValue: 0,
                            maxValue: 59,
                            listViewWidth: 60.0,
                            onChanged: (val) {})
                      ]),
                ],
              ),
            ),
            Container(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 35.0, bottom: 35.0),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          child: RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Colors.green[700],
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                            child: Text(
                              "pon",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          child: RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Colors.green[700],
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                            child: Text(
                              "wt",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          child: RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Colors.green[700],
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                            child: Text(
                              "śr",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          child: RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Colors.green[700],
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                            child: Text(
                              "czw",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          child: RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Colors.green[700],
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                            child: Text(
                              "pt",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          child: RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Colors.green[700],
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                            child: Text(
                              "sb",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          child: RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Colors.green[700],
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                            child: Text(
                              "nd",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: [
                        Text(
                          "Wbiracja",
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.green[700]),
                        ),
                        Switch(
                          value: true,
                          onChanged: null,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: [
                        Text(
                          "Drzemka",
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.green[700]),
                        ),
                        Text("5 minut, 3 razy"),
                        Switch(
                          value: true,
                          onChanged: null,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: RaisedButton(
                      onPressed: (){},
                      padding: EdgeInsets.symmetric(
                        horizontal: 45.0,
                        vertical: 10.0,
                      ),
                      color: Colors.red,
                      child: Text(
                        "Anuluj",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 45.0,
                        vertical: 10.0,
                      ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: RaisedButton(
                      onPressed: (){},
                      padding: EdgeInsets.symmetric(
                        horizontal: 45.0,
                        vertical: 10.0,
                      ),
                      color: Colors.red,
                      child: Text(
                        "Zapisz",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
