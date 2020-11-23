import 'package:flutter/material.dart';
import 'package:projekt_pum/Minutnik.dart';
import 'Stoper.dart';
import 'Minutnik.dart';
import 'Budzik.dart';


void main() {
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
        title: Text("Projekt PUM"),
        centerTitle: true,
        bottom: TabBar(
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
          unselectedLabelColor: Colors.white54,
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

