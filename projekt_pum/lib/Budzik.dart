import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'data.dart';
import 'main.dart';
import 'New_Alarm.dart';
import 'Edit_Alarm.dart';

class Budzik extends StatefulWidget {
  @override
  _Budzik createState() => _Budzik();
}

class _Budzik extends State<Budzik> {
  // Switche
  bool isSwitched = false;

  //Data wyświetlana pod czasem
  DateFormat dateFormat;
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = new DateFormat.MMMMd('pl');
  }

  //Usuwanie danego alarmu

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
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
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
                        Text(
                          formattedDate,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 80),
                        IconButton(
                          iconSize: 36,
                          color: Colors.lightGreenAccent.shade700,
                          icon: Icon(Icons.delete_forever),
                          onPressed: () {
                            scheduleAlarm();
                          },
                        ),
                        IconButton(
                          iconSize: 30,
                          color: Colors.lightGreenAccent.shade700,
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditAlarm()),
                            );
                          },
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
                Text(''),
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
