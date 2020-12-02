import 'dart:async';
import 'dart:ui';
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
  //Zmienne
  Timer timer;
  Timer timer2;
  DateFormat timeFormat;
  Future<List<Alarm>> _alarms;
  bool isSwitched = false;
  DateFormat dateFormat;
  int OneDrzemka = 1;

  // Init state
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = new DateFormat.MMMMd('pl');
    timer = Timer.periodic(Duration(seconds:1), (Timer t) => checkForAlarms());
    timer2 = Timer.periodic(Duration(days: 1), (Timer t) => autoUdateDates());
    _alarms = getAlarms();

  }
  // Funkcja automatycznie sprawdzająca datę co godzinę czy jest poprawna
  autoUdateDates() async {
    List<Alarm> alarms = await getAlarms();
    var pon=1;
    var wt=2;
    var sr=3;
    var czw=4;
    var pt=5;
    var sb=6;
    var nd=7;
    DateTime tomorrow = new DateTime.now().add(Duration(days: 1));
    for(var alarm in alarms){
      if(tomorrow.weekday==pon){
        if(alarm.Monday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 1));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Tuesday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 2));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Wednesday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 3));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Thursday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 4));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Friday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 5));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Saturday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 6));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Sunday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 7));
          updateAlarm(alarm);
          break;
        }
      }
      else if(tomorrow.weekday==wt){
        if(alarm.Tuesday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 1));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Wednesday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 2));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Thursday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 3));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Friday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 4));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Saturday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 5));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Sunday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 6));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Monday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 7));
          updateAlarm(alarm);
          break;
        }
      }
      else if(tomorrow.weekday==sr){
        if(alarm.Wednesday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 1));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Thursday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 2));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Friday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 3));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Saturday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 4));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Sunday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 5));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Monday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 6));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Tuesday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 7));
          updateAlarm(alarm);
          break;
        }
      }
      else if(tomorrow.weekday==czw){
        if(alarm.Thursday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 1));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Friday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 2));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Saturday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 3));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Sunday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 4));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Monday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 5));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Tuesday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 6));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Wednesday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 7));
          updateAlarm(alarm);
          break;
        }
      }
      else if(tomorrow.weekday==pt){
        if(alarm.Friday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 1));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Saturday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 2));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Sunday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 3));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Monday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 4));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Tuesday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 5));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Wednesday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 6));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Thursday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 7));
          updateAlarm(alarm);
          break;
        }
      }
      else if(tomorrow.weekday==sb){
        if(alarm.Saturday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 1));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Sunday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 2));
          updateAlarm(alarm);
          break;
        }
        if(alarm.Monday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 3));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Tuesday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 4));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Wednesday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 5));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Thursday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 6));
          updateAlarm(alarm);
          break;
        }
        else if(alarm.Friday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 7));
          updateAlarm(alarm);
          break;
        }
      }
      else if(tomorrow.weekday==nd){
       if(alarm.Sunday==1){
          alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 1));
          updateAlarm(alarm);
          break;
        }
       else if(alarm.Monday==1){
         alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 2));
         updateAlarm(alarm);
         break;
       }
       else if(alarm.Tuesday==1){
         alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 3));
         updateAlarm(alarm);
         break;
       }
       else if(alarm.Wednesday==1){
         alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 4));
         updateAlarm(alarm);
         break;
       }
       else if(alarm.Thursday==1){
         alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 5));
         updateAlarm(alarm);
         break;
       }
       else if(alarm.Friday==1){
         alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 6));
         updateAlarm(alarm);
         break;
       }
       else if(alarm.Saturday==1){
         alarm.Alarm_DateTime=alarm.Alarm_DateTime.add(Duration(days: 7));
         updateAlarm(alarm);
         break;
       }
  }
    }
  }

  // checkNextDay(Alarm alarm)
  // {
  //   DateTime xd = alarm.Alarm_DateTime;
  //
  //   int weekday = xd.weekday;
  //
  //   // which days alarm is running
  //   var weekdayList= [false,false,false,false,false,false,false];
  //   if(alarm.Monday==1)
  //     weekdayList[0]=true;
  //   if(alarm.Tuesday==1)
  //     weekdayList[1]=true;
  //   if(alarm.Wednesday==1)
  //     weekdayList[2]=true;
  //   if(alarm.Tuesday==1)
  //     weekdayList[3]=true;
  //   if(alarm.Thursday==1)
  //     weekdayList[4]=true;
  //   if(alarm.Friday==1)
  //     weekdayList[5]=true;
  //   if(alarm.Saturday==1)
  //     weekdayList[6]=true;
  //   if(alarm.Sunday==1)
  //     weekdayList[7]=true;
  //
  //   var copy = weekdayList;
  //   weekdayList.addAll(copy);
  //
  //   int weekdayCopy=weekday+1;
  //   int amountOfDaysToAdd=0;
  //
  //     for(var i=weekday;i<=weekday+7;i++)
  //       {
  //         amountOfDaysToAdd++;
  //         if(weekdayList[i-1])
  //           {
  //             break;
  //           }
  //       }
  //     print("iledodac"+amountOfDaysToAdd.toString());
  // }


  // Funkcja sprawdzająca co sekundę czy jakiś alarm powinien startować
  checkForAlarms() async {
    List<Alarm> alarms = await getAlarms();
    DateTime now =new DateTime.now();
    now = new DateTime(now.year,now.month,now.day,now.hour,now.minute,now.second,0,0).add(Duration(hours: 1));
    for(var alarm in alarms)
      {
        if(alarm.Alarm_DateTime==now && alarm.Alarm_isActive==1)
          {
            scheduleAlarm();
            if(alarm.Alarm_Vibration==1){
              if (await Vibration.hasVibrator()) {
                if (await Vibration.hasCustomVibrationsSupport()) {
                  Vibration.vibrate(pattern: [500, 1000, 500, 1000, 500, 1000, 500, 1000, 500, 1000, 500, 1000, 500, 500]);
                }
                else{
                  Vibration.vibrate();
                  await Future.delayed(Duration(milliseconds: 500));
                  Vibration.vibrate();
                }
              }
            }
            if(alarm.Alarm_Drzemka==1){
              Alarm copyOfAlarm = Alarm.copy2(alarm,alarm.Alarm_DateTime.add(new Duration(minutes: 4)),0);
              updateAlarm(copyOfAlarm);
            }
            if(alarm.Alarm_Drzemka==0){
                Alarm copyOfAlarm = Alarm.copy2(alarm,alarm.Alarm_DateTime.add(new Duration(minutes: -4)),1);
                updateAlarm(copyOfAlarm);
            }
          }
      }
  }


  @override
  void dispose() {
    timer?.cancel();
    timer2?.cancel();
    super.dispose();
  }


// Operacje na DB
  var db;
  remove_from_DB(id) async {
    Database db =
        await openDatabase(join(await getDatabasesPath(), 'AlarmDB.db'));
    await db.delete('BudzikEntity', where: 'ID_Alarm = ?', whereArgs: [id]);
    print("Usunięto pomyślnie!");
  }
  Future<void> updateAlarm(Alarm alarm) async {
    Database db = await openDatabase(join(await getDatabasesPath(),'AlarmDB.db'));
    await db.insert('BudzikEntity',alarm.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    print("Po aktualizacji: "+alarm.toString());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Alarm>>(
      future: _alarms,
      builder: (BuildContext context, AsyncSnapshot<List<Alarm>> snapshot) {
        if (snapshot.hasData) {
          return
            Container(
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
                                          setState(() {
                                            _alarms = getAlarms();
                                           });
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
                                                builder: (context) => EditAlarm(snapshot.data[index])
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
