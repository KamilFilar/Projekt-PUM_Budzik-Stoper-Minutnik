import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Stoper.dart';
import 'Minutnik.dart';
import 'Budzik.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid = AndroidInitializationSettings('clock');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });

  runApp(MyApp());
}

class Alarm {
  int ID_Alarm;
  DateTime Alarm_DateTime;
  int Alarm_Vibration;
  int Alarm_Drzemka;
  int Alarm_isActive;
  int Monday;
  int Tuesday;
  int Wednesday;
  int Thursday;
  int Friday;
  int Saturday;
  int Sunday;

  Alarm(
      {this.ID_Alarm,
      this.Alarm_DateTime,
      this.Alarm_Vibration,
      this.Alarm_Drzemka,
      this.Alarm_isActive,
      this.Monday,
      this.Tuesday,
      this.Wednesday,
      this.Thursday,
      this.Friday,
      this.Saturday,
      this.Sunday});

  Alarm.fromMap(Map<String, dynamic> map) {
    this.ID_Alarm = map['ID_Alarm'];
    this.Alarm_DateTime = DateTime.parse(map['Alarm_DateTime']);
    this.Alarm_Vibration = map['Alarm_Vibration'];
    this.Alarm_Drzemka = map['Alarm_Drzemka'];
    this.Alarm_isActive = map['Alarm_isActive'];
    this.Monday = map['Monday'];
    this.Tuesday = map['Tuesday'];
    this.Wednesday = map['Wednesday'];
    this.Thursday = map['Thursday'];
    this.Friday = map['Friday'];
    this.Saturday = map['Saturday'];
    this.Sunday = map['Sunday'];
  }

  Map<String, dynamic> toMap() {
    return {
      'ID_Alarm': ID_Alarm,
      'Alarm_DateTime': Alarm_DateTime.toString(),
      'Alarm_Vibration': Alarm_Vibration,
      'Alarm_Drzemka': Alarm_Drzemka,
      'Alarm_isActive': Alarm_isActive,
      'Monday': Monday,
      'Tuesday': Tuesday,
      'Wednesday': Wednesday,
      'Thursday': Thursday,
      'Friday': Friday,
      'Saturday': Saturday,
      'Sunday': Sunday,
    };
  }
  @override
  String toString() {
    return 'Alarm{ID: $ID_Alarm, Czas: $Alarm_DateTime, Aktywny: $Alarm_isActive}';
  }
  @override
  String toString2() {
    return 'Alarm{ID: $ID_Alarm, Czas: $Alarm_DateTime, Aktywny: $Alarm_isActive, Wibracja: $Alarm_Vibration, Drzemka: $Alarm_Drzemka,'
        'Poniedziałek: $Monday, Wtorek: $Tuesday, środa: $Wednesday, Czwartek: $Thursday, Piątek: $Friday, Sobota: $Saturday, Niedziela: $Sunday}';
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  var db;
  initDb() async {
    print("Zainicjalizowano bazę danych");
    Database db =
        await openDatabase(join(await getDatabasesPath(), 'AlarmDB.db'));
    // await db.query('alarms').then((value) => print(value));
    print("Inicjalizacja zakończona");
  }

  //------------------------ Budzik ---------------------------\\
  Widget alarm() {
    return Budzik();
  }

  //------------------------ Minutnik ------------------------\\
  Widget timer() {
    return Minutnik();
  }

  //------------------------ Stoper---------------------------\\
  Widget stopwach() {
    List<String> x = new List(10);
    x[0] = null;
    x[1] = x[0];
    x[2] = x[1];
    x[3] = x[2];
    x[4] = x[3];
    x[5] = x[4];
    x[6] = x[5];
    x[7] = x[6];
    x[8] = x[7];
    x[9] = x[8];
    return Stoper(x);
  }

  //------------------------ AppBar ------------------------\\
  TabController tb;
  @override
  void initState() {
    tb = TabController(length: 3, vsync: this);
    super.initState();
    initDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Projekt PUM',
          style: GoogleFonts.comicNeue(
              fontWeight: FontWeight.w700,
              fontSize: 30,
              color: Colors.lightGreenAccent.shade400),
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
                ]),
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
        bottom: TabBar(
          indicatorColor: Colors.lightGreenAccent.shade700,
          tabs: <Widget>[
            Text(
              'Budzik',
              style: GoogleFonts.comicNeue(
                fontWeight: FontWeight.w700,
                fontSize: 26,
              ),
            ),
            Text(
              "Stoper",
              style: GoogleFonts.comicNeue(
                fontWeight: FontWeight.w700,
                fontSize: 26,
              ),
            ),
            Text(
              "Minutnik",
              style: GoogleFonts.comicNeue(
                fontWeight: FontWeight.w700,
                fontSize: 26,
              ),
            ),
          ],
          labelPadding: EdgeInsets.only(
            bottom: 10.0,
          ),
          labelStyle: TextStyle(
            fontSize: 20.0,
          ),
          unselectedLabelColor: Colors.white,
          controller: tb,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          alarm(),
          stopwach(),
          timer(),
        ],
        controller: tb,
      ),
    );
  }
}
