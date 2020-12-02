import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:path/path.dart';
import 'package:projekt_pum/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Budzik.dart';

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

class EditAlarm extends StatefulWidget {
  Alarm alarm;
  EditAlarm(this.alarm);

  @override
  _EditAlarm createState() => _EditAlarm();
}

class _EditAlarm extends State<EditAlarm> with TickerProviderStateMixin {
  //Numberpicker
  @override
  void initState() {
    super.initState();
  }
  int hour = 0;
  int min = 0;

  //Switche
  bool isSwitched_wib = true;
  bool isSwitched_drzemka = true;


  //Dni tygodnia
  bool pressed_pon = true;
  bool pressed_wt = true;
  bool pressed_sr = true;
  bool pressed_czw = true;
  bool pressed_pt = true;
  bool pressed_sb = true;
  bool pressed_nd = true;
  int pon = 1;
  int wt = 1;
  int sr = 1;
  int czw = 1;
  int pt = 1;
  int sb = 1;
  int nd = 1;



  //Dodawanie nowego alarmu
  var hour_to_add = 0; // 6
  var min_to_add = 0; // 30
  var day_to_add = DateTime.now().day+1;

  DateTime date_to_add;

  int vibration_to_add = 1;
  int drzemka_to_add = 1;
  int isActive_status = 1;

  void CheckDay(){
    bool isToday = false;
    if(hour_to_add>=DateTime.now().hour){ //Gdzina alarmu >= Aktualna godzina
      isToday = true;
    }
    if(min_to_add>DateTime.now().minute && isToday==true){ //Min. alarmu > Aktualna min i isToday = true
      day_to_add = DateTime.now().day;
    }
    else if(hour_to_add>DateTime.now().hour){ // Gdzina alarmu > Aktualna godzina
      day_to_add = DateTime.now().day;
    }
    date_to_add = DateTime(DateTime.now().year, DateTime.now().month, day_to_add, hour_to_add, min_to_add);
    var pon=1;
    var wt=2;
    var sr=3;
    var czw=4;
    var pt=5;
    var sb=6;
    var nd=7;
    var now = new DateTime.now().add(Duration(days: 1));
    if(pressed_pon == false && now.weekday==pon){
      date_to_add = date_to_add.add(Duration(days: 1));
    }
    if(pressed_wt == false && now.weekday==wt){
      date_to_add = date_to_add.add(Duration(days: 1));
    }
    if(pressed_sr == false && now.weekday==sr){
      date_to_add = date_to_add.add(Duration(days: 1));
    }
    if(pressed_czw == false && now.weekday==czw){
      date_to_add = date_to_add.add(Duration(days: 1));
    }
    if(pressed_pt == false && now.weekday==pt){
      date_to_add = date_to_add.add(Duration(days: 1));
    }
    if(pressed_sb == false && now.weekday==sb){
      date_to_add = date_to_add.add(Duration(days: 1));
    }
    if(pressed_nd == false && now.weekday==nd){
      date_to_add = date_to_add.add(Duration(days: 1));
    }
  }

  var db;
  Future<void> updateAlarm(Alarm alarm) async {
    Database db = await openDatabase(join(await getDatabasesPath(),'AlarmDB.db'));
    await db.insert('BudzikEntity',alarm.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    print("Po aktualizacji: "+alarm.toString());
  }

  checkAlarmExist(Alarm A1) async{
    List<Alarm> alarms = await getAlarms();
    for(var alarm in alarms)
    {
      if(alarm.compare(alarm, A1)){
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text("Edytuj alarm",
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
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 25, bottom: 20),
                child: Text("UWAGA! Ustawiono podstawowe dane.",
                  style: GoogleFonts.comicNeue(
                      fontWeight: FontWeight.w700,
                      fontSize: 21,
                      color: Colors.redAccent.shade700),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 70, right: 70),
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
                            initialValue: hour,
                            minValue: 0,
                            maxValue: 23,
                            listViewWidth: 60.0,
                            onChanged: (val) {
                              setState(() {
                                hour = val;
                                hour_to_add = hour.toInt();
                              });
                            })
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
                            initialValue: min,
                            minValue: 0,
                            maxValue: 59,
                            listViewWidth: 60.0,
                            onChanged: (val) {
                              setState(() {
                                min = val;
                                min_to_add = min.toInt();
                              });
                            })
                      ]),
                ],
              ),
            ),
            Container(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
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
                        decoration: pressed_pon ? BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          shape: BoxShape.circle,
                        )
                            : BoxDecoration(
                          border: Border.all(color: Colors.green.shade900, width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: RaisedButton(
                          elevation: 2.0,
                          padding: EdgeInsets.all(0.0),
                          shape: CircleBorder(),
                          onPressed: () {
                            setState(() {
                              pressed_pon = !pressed_pon;
                              if(pressed_pon==false){
                                pon = 0;
                              }
                              if(pressed_pon==true){
                                pon = 1;
                              }
                            });
                            print('Poniedziałek: '+pon.toString());
                            print('Presed: '+pressed_pon.toString());
                          },
                          child: Ink(
                            decoration: pressed_pon ? BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.grey.shade900,
                                Colors.green.shade900,
                                Colors.grey.shade900,
                              ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              shape: BoxShape.circle,
                            )
                                :   BoxDecoration(
                              color: Colors.grey.shade900,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              constraints: const BoxConstraints(minWidth: 52.0, minHeight: 52.0), // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: const Text(
                                'pon',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: pressed_wt ? BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          shape: BoxShape.circle,
                        )
                            : BoxDecoration(
                          border: Border.all(color: Colors.green.shade900, width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: RaisedButton(
                          elevation: 2.0,
                          padding: EdgeInsets.all(0.0),
                          shape: CircleBorder(),
                          onPressed: () {
                            setState(() {
                              pressed_wt = !pressed_wt;
                              if(pressed_wt==false){
                                wt = 0;
                              }
                              if(pressed_wt==true){
                                wt = 1;
                              }
                            });
                            print('Wtorek: '+wt.toString());
                            print('Presed: '+pressed_wt.toString());
                          },
                          child: Ink(
                            decoration: pressed_wt ? BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.grey.shade900,
                                Colors.green.shade900,
                                Colors.grey.shade900,
                              ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              shape: BoxShape.circle,
                            )
                                :   BoxDecoration(
                              color: Colors.grey.shade900,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              constraints: const BoxConstraints(minWidth: 52.0, minHeight: 52.0), // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: const Text(
                                'wt',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: pressed_sr ? BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          shape: BoxShape.circle,
                        )
                            : BoxDecoration(
                          border: Border.all(color: Colors.green.shade900, width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: RaisedButton(
                          elevation: 2.0,
                          padding: EdgeInsets.all(0.0),
                          shape: CircleBorder(),
                          onPressed: () {
                            setState(() {
                              pressed_sr = !pressed_sr;
                              if(pressed_sr == false){
                                sr = 0;
                              }
                              if(pressed_sr == true){
                                sr = 1;
                              }
                            });
                            print('środa: '+sr.toString());
                            print('Presed: '+pressed_sr.toString());
                          },
                          child: Ink(
                            decoration: pressed_sr ? BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.grey.shade900,
                                Colors.green.shade900,
                                Colors.grey.shade900,
                              ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              shape: BoxShape.circle,
                            )
                                :   BoxDecoration(
                              color: Colors.grey.shade900,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              constraints: const BoxConstraints(minWidth: 52.0, minHeight: 52.0), // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: const Text(
                                'śr',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: pressed_czw ? BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          shape: BoxShape.circle,
                        )
                            : BoxDecoration(
                          border: Border.all(color: Colors.green.shade900, width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: RaisedButton(
                          elevation: 2.0,
                          padding: EdgeInsets.all(0.0),
                          shape: CircleBorder(),
                          onPressed: () {
                            setState(() {
                              pressed_czw = !pressed_czw;
                              if(pressed_czw == false){
                                czw = 0;
                              }
                              if(pressed_czw == true){
                                czw= 1;
                              }
                            });
                            print('Czwartek: '+czw.toString());
                            print('Presed: '+pressed_czw.toString());
                          },
                          child: Ink(
                            decoration: pressed_czw ? BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.grey.shade900,
                                Colors.green.shade900,
                                Colors.grey.shade900,
                              ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              shape: BoxShape.circle,
                            )
                                :   BoxDecoration(
                              color: Colors.grey.shade900,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              constraints: const BoxConstraints(minWidth: 52.0, minHeight: 52.0), // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: const Text(
                                'czw',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
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
                        decoration: pressed_pt ? BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          shape: BoxShape.circle,
                        )
                            : BoxDecoration(
                          border: Border.all(color: Colors.green.shade900, width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: RaisedButton(
                          elevation: 2.0,
                          padding: EdgeInsets.all(0.0),
                          shape: CircleBorder(),
                          onPressed: () {
                            setState(() {
                              pressed_pt = !pressed_pt;
                              if(pressed_pt == false){
                                pt = 0;
                              }
                              if(pressed_pt == true){
                                pt = 1;
                              }
                            });
                            print('Piątek: '+pt.toString());
                            print('Presed: '+pressed_pt.toString());
                          },
                          child: Ink(
                            decoration: pressed_pt ? BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.grey.shade900,
                                Colors.green.shade900,
                                Colors.grey.shade900,
                              ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              shape: BoxShape.circle,
                            )
                                :   BoxDecoration(
                              color: Colors.grey.shade900,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              constraints: const BoxConstraints(minWidth: 52.0, minHeight: 52.0), // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: const Text(
                                'pt',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: pressed_sb ? BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          shape: BoxShape.circle,
                        )
                            : BoxDecoration(
                          border: Border.all(color: Colors.blue.shade900, width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: RaisedButton(
                          elevation: 2.0,
                          padding: EdgeInsets.all(0.0),
                          shape: CircleBorder(),
                          onPressed: () {
                            setState(() {
                              pressed_sb = !pressed_sb;
                              if(pressed_sb == false){
                                sb = 0;
                              }
                              if(pressed_sb == true){
                                sb = 1;
                              }
                            });
                            print('Sobota: '+sb.toString());
                            print('Presed: '+pressed_sb.toString());
                          },
                          child: Ink(
                            decoration: pressed_sb ? BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.grey.shade900,
                                Colors.blue.shade900,
                                Colors.grey.shade900,
                              ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              shape: BoxShape.circle,
                            )
                                :   BoxDecoration(
                              color: Colors.grey.shade900,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              constraints: const BoxConstraints(minWidth: 52.0, minHeight: 52.0), // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: const Text(
                                'sb',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: pressed_nd ? BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          shape: BoxShape.circle,
                        )
                            : BoxDecoration(
                          border: Border.all(color: Colors.blue.shade900, width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: RaisedButton(
                          elevation: 2.0,
                          padding: EdgeInsets.all(0.0),
                          shape: CircleBorder(),
                          onPressed: () {
                            setState(() {
                              pressed_nd = !pressed_nd;
                              if(pressed_nd == false){
                                nd = 0;
                              }
                              if(pressed_nd == true){
                                nd = 1;
                              }
                            });
                            print('Niedziela: '+nd.toString());
                            print('Presed: '+pressed_nd.toString());
                          },
                          child: Ink(
                            decoration: pressed_nd ? BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.grey.shade900,
                                Colors.blue.shade900,
                                Colors.grey.shade900,
                              ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              shape: BoxShape.circle,
                            )
                                :   BoxDecoration(
                              color: Colors.grey.shade900,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              constraints: const BoxConstraints(minWidth: 52.0, minHeight: 52.0), // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: const Text(
                                'nd',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
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
              padding: EdgeInsets.only(top: 5),
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
                    value: isSwitched_wib,
                    onChanged: (value){
                      setState(() {
                        isSwitched_wib=value;
                        if(isSwitched_wib==true){
                          vibration_to_add=1;
                        }
                        else{
                          vibration_to_add=0;
                        }
                        print('Wibracja: '+vibration_to_add.toString());
                      });
                    },
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
              padding: EdgeInsets.only(bottom: 5),
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
                    value: isSwitched_drzemka,
                    onChanged: (value){
                      setState(() {
                        isSwitched_drzemka=value;
                        if(isSwitched_drzemka==true){
                          drzemka_to_add=1;
                        }
                        else{
                          drzemka_to_add=0;
                        }
                        print('Drzemka: '+drzemka_to_add.toString());
                      });
                    },
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
                      onPressed: () async {
                        CheckDay();
                        if(pon==0 && wt==0 && sr==0 && czw==0 && pt==0 && sb==0 && nd==0){
                          pon = wt = sr = czw = pt = sb = nd = 1;
                          print("Ustawiono wartości domyślne dla dni ponieważ nie wybrano żadnego!");
                        }
                        bool test = await checkAlarmExist(Alarm(Alarm_DateTime: date_to_add, Alarm_Vibration: vibration_to_add, Alarm_Drzemka: drzemka_to_add, Alarm_isActive: 1,
                            Monday: pon, Tuesday: wt, Wednesday: sr, Thursday: czw, Friday: pt, Saturday: sb, Sunday: nd));
                        print("Bool: "+test.toString());
                        if(test){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(0)));
                        }
                        else{
                          updateAlarm(Alarm(Alarm_DateTime: date_to_add, Alarm_Vibration: vibration_to_add, Alarm_Drzemka: drzemka_to_add, Alarm_isActive: 1,
                              Monday: pon, Tuesday: wt, Wednesday: sr, Thursday: czw, Friday: pt, Saturday: sb, Sunday: nd));

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(0)));
                        }
                      },
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