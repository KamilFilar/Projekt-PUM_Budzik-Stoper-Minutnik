import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'Stoper.dart';
import 'Minutnik.dart';
import 'Budzik.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid =
  AndroidInitializationSettings('clock');
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  //------------------------ Budzik ---------------------------\\
  Widget alarm(){
    return Budzik();
  }
  //------------------------ Minutnik ------------------------\\
  Widget timer(){
    return Minutnik();
  }
  //------------------------ Stoper---------------------------\\
  Widget stopwach() {
    List<String> x = new List(5);
    x[0] = "";
    x[1] = x[0];
    x[2] = x[1];
    x[3] = x[2];
    x[4] = x[3];
    return Stoper(x);
  }
  //------------------------ AppBar ------------------------\\
  TabController tb;
  @override
  void initState() {
    tb = TabController(length: 3, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Colors.green,
        title: Text("Projekt PUM"),
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
        bottom: TabBar(
          indicatorColor: Colors.lightGreenAccent.shade700,
          tabs: <Widget>[
            Text("Budzik"),
            Text("Stoper"),
            Text("Minutnik"),
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

