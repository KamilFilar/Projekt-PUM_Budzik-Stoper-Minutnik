import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:projekt_pum/Edit_Alarm.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vibration/vibration.dart';
import 'package:path/path.dart';


import 'main.dart';
import 'New_Alarm.dart';


Future<List<Alarm>> getAlarms() async {
  List<Map<String, dynamic>> alarmsDB;
  Database db =
  await openDatabase(join(await getDatabasesPath(), 'AlarmDB.db'));
  await db.query('BudzikEntity').then((value) => alarmsDB = value);

  // print(alarmsDB);
  // print(alarmsDB.length);

  List<Alarm> alarms=List.generate(alarmsDB.length, (index) {
    Alarm alarm = Alarm.fromMap(alarmsDB[index]);
    return alarm;
  });
  // print(alarms);
  return alarms;
}

class Budzik extends StatefulWidget {
  List<Alarm> alarms;
  Budzik({this.alarms});

  @override
  _Budzik createState() => _Budzik();
}

class _Budzik extends State<Budzik> {
  Timer timer;
  DateFormat timeFormat;
  Future<List<Alarm>> _alarms = getAlarms();
  bool isSwitched = false;
  DateFormat dateFormat;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = new DateFormat.MMMMd('pl');
    timer = Timer.periodic(Duration(seconds:1), (Timer t) => checkForAlarms());
  }

  checkForAlarms() async {
    List<Alarm> alarms = await getAlarms();
    DateTime now =new DateTime.now();
    now = new DateTime(now.year,now.month,now.day,now.hour,now.minute,now.second,0,0).add(Duration(hours: 1));
    //print("check alarms: "+now.toString());
    for(var alarm in alarms)
      {
        if(alarm.Alarm_DateTime==now)
          AlarmStart();
      }
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


// Operacje na DB
  var db;

  remove_from_DB(id) async {
    Database db =
        await openDatabase(join(await getDatabasesPath(), 'AlarmDB.db'));
    await db.delete('BudzikEntity', where: 'ID_Alarm = ?', whereArgs: [id]);
    setState(() {});
    print("Usunięto pomyślnie!");
  }

  Future<void> updateAlarm(Alarm alarm) async {
    Database db = await openDatabase(join(await getDatabasesPath(),'AlarmDB.db'));
    await db.insert('BudzikEntity',alarm.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    print("Po aktualizacji: "+alarm.toString());
  }


  void AlarmStart() async{
    scheduleAlarm();
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(pattern: [500, 1000, 500, 1000, 500, 1000, 500, 1000, 500, 1000, 500, 1000, 500, 500]);
    }
  }

  @override
  Widget build(BuildContext context) {

    // https://www.greycastle.se/reloading-future-with-flutter-futurebuilder/


    return FutureBuilder<List<Alarm>>(
      future: _alarms,
      builder: (BuildContext context, AsyncSnapshot<List<Alarm>> snapshot) {
        if (snapshot.hasData) {
          return Container(
                color: Colors.grey.shade900,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 40),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
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
                                    color: Colors.lightGreenAccent.shade700
                                        .withOpacity(0.8),
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
                                          Text(
                                            DateFormat('Hm')
                                                .format(snapshot.data[index].Alarm_DateTime),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Switch(
                                        value: snapshot.data[index].Alarm_isActive == 1 ? true : false,
                                        onChanged: (value) {
                                          setState(() {
                                            if (snapshot.data[index].Alarm_isActive == 1){
                                              snapshot.data[index].Alarm_isActive = 0;
                                            }
                                            else{
                                              snapshot.data[index].Alarm_isActive = 1;
                                            }
                                            updateAlarm(snapshot.data[index]);
                                          });
                                          // if(DateTime.now() == snapshot.data[index].Alarm_DateTime && snapshot.data[index].Alarm_isActive==1){
                                          //   AlarmStart();
                                          // }
                                        },
                                        activeTrackColor:
                                        Colors.lightGreenAccent.shade700,
                                        activeColor: Colors.white,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(width: 10),
                                      Text(dateFormat.format(snapshot.data[index].Alarm_DateTime),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 70),
                                      IconButton(
                                        iconSize: 36,
                                        color: Colors.lightGreenAccent.shade700,
                                        icon: Icon(Icons.delete_forever),
                                        onPressed: () {
                                          remove_from_DB(snapshot.data[index].ID_Alarm);
                                        },
                                      ),
                                      IconButton(
                                        iconSize: 30,
                                        color: Colors.lightGreenAccent.shade700,
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => EditAlarm(snapshot.data[index]
                                                )
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    Container(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.lightGreenAccent.shade700,
                                    width: 2),
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
                                    MaterialPageRoute(
                                        builder: (context) => NewAlarm()),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],)
        );
        }else
          return SizedBox(
            child: CircularProgressIndicator(),
            width: 50,
            height: 50,
          );
      }
    );
  }



  void scheduleAlarm() async {
    var scheduledNotificationDateTime =
        DateTime.now();
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
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    // ignore: deprecated_member_use
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Alarm uruchomiony!',
        'Czas na działanie :)',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }


}
