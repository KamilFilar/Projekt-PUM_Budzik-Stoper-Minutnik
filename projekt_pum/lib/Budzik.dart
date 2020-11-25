import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'data.dart';
import 'main.dart';

class Budzik extends StatefulWidget {
  @override
  _Budzik createState() => _Budzik();
}

class _Budzik extends State<Budzik> {
  bool isSwitched = false;

  DateFormat dateFormat;
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = new DateFormat.MMMd('pl');
  }

  @override
  Widget build(BuildContext context) {

    var dateTime = new DateTime.now().add(Duration(days: 1));
    String formattedDate = dateFormat.format(dateTime);


    return Container(
      color: Colors.grey.shade900,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child:
          ListView(
            children: alarms.map<Widget>((alarm) {
              return Container(
                margin: const EdgeInsets.only(bottom: 25),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey.shade900,
                      Colors.green.shade900,
                      Colors.green.shade700,
                      Colors.grey.shade900,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  border: Border.all(
                    width: 2,
                    color: Colors.lightGreenAccent.shade700,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.lightGreenAccent.shade700.withOpacity(0.8),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(4, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.all((Radius.circular(30))),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(width: 8),
                            Text('14:00',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          iconSize: 40,
                          color: Colors.white,
                          icon: Icon(Icons.delete_forever),
                          onPressed: () {
                            scheduleAlarm();
                            },
                        ),
                        Switch(
                          value: isSwitched,
                          onChanged: (value){
                            setState(() {
                              isSwitched=value;
                              print(isSwitched);
                            });
                          },
                          activeTrackColor: Colors.lightGreenAccent.shade700,
                          activeColor: Colors.white,
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 10),
                        Text(formattedDate,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).followedBy([
              if (alarms.length < 5)
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.lightGreenAccent.shade700, width: 2),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.grey.shade900,
                                  Colors.green.shade900,
                                  Colors.grey.shade900,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              iconSize: 40,
                              color: Colors.lightGreenAccent.shade700,
                              icon: Icon(Icons.add_alert),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => NewAlarm()),
                                );
                              },
                            ),
                          ),

                        ],
                      )
                  )
              else
                Text('Only 5 alarms allowed!'),
            ]).toList(),
          ),
          ),
        ],
      ),
    );
  }

  void scheduleAlarm() async {
    var scheduledNotificationDateTime = DateTime.now().add(Duration(seconds: 5));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'clock',
      sound: RawResourceAndroidNotificationSound('song'),
      largeIcon: DrawableResourceAndroidBitmap('clock'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'song.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    // ignore: deprecated_member_use
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Dzień dobry!',
        'Pora wstawać :)',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }
}



// Nowy alaram
class NewAlarm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text("Dodaj nowy alarm",
          style: TextStyle(
              fontSize: 23
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Colors.grey.shade900,
                  Colors.green.shade900,
                  Colors.green.shade700,
                  Colors.grey.shade900,
                ]
            ),
            border: Border.all(
              width: 1,
              color: Colors.green.shade900,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.lightGreenAccent.shade700.withOpacity(0.8),
                blurRadius: 8,
                spreadRadius: 2,
                offset: Offset(4, 4),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 40, left: 70, right: 70),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.shade900,
                    Colors.green.shade900,
                    Colors.green.shade900,
                    Colors.grey.shade900,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                border: Border.all(
                  width: 2,
                  color: Colors.lightGreenAccent.shade700,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.lightGreenAccent.shade700.withOpacity(0.8),
                    blurRadius: 15,
                    spreadRadius: 8,
                    offset: Offset(4, 4),
                  ),
                ],
                borderRadius: BorderRadius.all((Radius.circular(30))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 13,
                            bottom: 5.0,
                            right: 10
                          ),
                          child: Text("Godzina",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        NumberPicker.integer(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                                bottom: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                              ),
                            ),
                            selectedTextStyle: TextStyle(
                                color: Colors.lightGreenAccent.shade700,
                                fontSize: 33
                            ),
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 30
                            ),
                            initialValue: 6,
                            minValue: 0,
                            maxValue: 23,
                            listViewWidth: 60.0,
                            onChanged: (val) {})
                      ]
                  ),

                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 13,
                            bottom: 5.0,
                            left: 10
                          ),
                          child: Text("Minuta",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        NumberPicker.integer(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                                bottom: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                              ),
                            ),
                            selectedTextStyle: TextStyle(
                                color: Colors.lightGreenAccent.shade700,
                                fontSize: 33
                            ),
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 30
                            ),
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
                  padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.grey.shade700),
                ),
              ),
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade900,
                              Colors.green.shade900,
                              Colors.grey.shade900,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
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
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade900,
                              Colors.green.shade900,
                              Colors.grey.shade900,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
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
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade900,
                              Colors.green.shade900,
                              Colors.grey.shade900,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
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
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade900,
                              Colors.green.shade900,
                              Colors.grey.shade900,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
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
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey.shade700),
                ),
              ),
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade900,
                              Colors.green.shade900,
                              Colors.grey.shade900,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
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
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue.shade700, width: 2),
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade900,
                              Colors.blue.shade900,
                              Colors.grey.shade900,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
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
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue.shade700, width: 2),
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade900,
                              Colors.blue.shade900,
                              Colors.grey.shade900,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
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
                    ],
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('Wibracja',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Switch(
                          value: false,
                          onChanged: (value){},
                          activeTrackColor: Colors.green.shade700,
                          activeColor: Colors.white,
                        )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey.shade700),
                ),
              ),
              padding: EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Drzemka',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: true,
                    onChanged: (value){},
                    activeTrackColor: Colors.green.shade700,
                    activeColor: Colors.white,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 25, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 20.0, left: 8.0),
                    child: RaisedButton(
                      onPressed: (){},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      color: Colors.green.shade900,
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.grey.shade900,
                            Colors.green.shade900,],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                            width: 2,
                            color: Colors.lightGreenAccent.shade700,
                          ),
                        ),
                        child: Container(
                          constraints: BoxConstraints(minWidth: 150, maxHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Zapisz",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 8.0, left: 20.0),
                    child: RaisedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.grey.shade900,
                            Colors.red.shade900,
                          ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                            width: 2,
                            color: Colors.redAccent.shade700,
                          ),
                        ),
                        child: Container(
                          constraints: BoxConstraints(minWidth: 150, maxHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Anuluj",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white
                            ),
                          ),
                        ),
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











class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.grey.shade900,
            child: Container(
              child: Row(
                children: <Widget>[
                  Text('bebebebbebe',
                  textAlign: TextAlign.center,)
                ],
              ),
            ),
      ),

    );
  }
}