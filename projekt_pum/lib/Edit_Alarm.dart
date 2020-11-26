import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';



class EditAlarm extends StatefulWidget {
  @override
  _EditAlarm createState() => _EditAlarm();
}

class _EditAlarm extends State<EditAlarm> with TickerProviderStateMixin {

  //Numberpicker
  @override
  void initState() {
    super.initState();
  }
  int hour = 6;
  int min = 30;

  //Switche
  bool isSwitched_wib = false;
  bool isSwitched_drzemka = false;
  int id_wib = 0;
  int id_drzemka = 0;

  //Dni tygodnia
  bool pressed_pon = true;
  bool pressed_wt = true;
  bool pressed_sr = true;
  bool pressed_czw = true;
  bool pressed_pt = true;
  bool pressed_sb = true;
  bool pressed_nd = true;
  bool pon = true;
  bool wt = true;
  bool sr = true;
  bool czw = true;
  bool pt = true;
  bool sb = true;
  bool nd = true;





  //Edytowanie alarmu



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
                            initialValue: hour,
                            minValue: 0,
                            maxValue: 23,
                            listViewWidth: 60.0,
                            onChanged: (val) {
                              setState(() {
                                hour = val;
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
                              });
                            })
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
                              pon = !pon;
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
                              wt = !wt;
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
                              sr = !sr;
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
                              czw = !czw;
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
                              pt = !pt;
                            });
                            print('Poniedziałek: '+pt.toString());
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
                              sb = !sb;
                            });
                            print('Poniedziałek: '+sb.toString());
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
                              nd = !nd;
                            });
                            print('Poniedziałek: '+nd.toString());
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
                      id_wib = 1;
                      setState(() {
                        isSwitched_wib=value;
                        print('Wibracja:'+isSwitched_wib.toString());
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
                      id_drzemka = 1;
                      setState(() {
                        isSwitched_drzemka=value;
                        print('Drzemka:'+isSwitched_drzemka.toString());
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