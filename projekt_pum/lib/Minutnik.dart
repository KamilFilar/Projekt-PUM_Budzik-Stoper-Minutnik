import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';


class Minutnik extends StatefulWidget {
  @override
  _Minutnik createState() => _Minutnik();
}

class _Minutnik extends State<Minutnik> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }
  int hour = 0;
  int min = 0;
  int sec = 0;
  int SetsTime = 0;
  int timeToResume = 0;
  String timeToDisplay = "00:00:00";

  bool started = true;
  bool stopped = true;

  bool checkTimer = true;

  void start() {
    setState(() {
      started = false;
      stopped = false;
    });
    SetsTime = (hour * 60 * 60) + (min * 60) + (sec);
    Timer.periodic(
        Duration(
          seconds: 1,
        ), (Timer t) {
      setState(() {
        if (SetsTime < 1 || checkTimer == false) {
          t.cancel();
          checkTimer = true;
          started = true;
          // Output after stop
          stopped = true;
          if (SetsTime < 60) {
            timeToDisplay = "00:00:" + SetsTime.toString();
          }
          if (SetsTime < 10) {
            timeToDisplay = "00:00:0" + SetsTime.toString();
          }
          if (SetsTime < 3600) {
            int min;
            int sec;
            min = SetsTime ~/ 60;
            sec = SetsTime - (min * 60);
            timeToDisplay = "00:" + min.toString() + ":" + sec.toString();
            if (min > 9 && sec > 9) {
              timeToDisplay = "00:" + min.toString() + ":" + sec.toString();
            }
            if (min > 9 && sec <= 9) {
              timeToDisplay = "00:" + min.toString() + ":0" + sec.toString();
            }
            if (min <= 9 && sec > 9) {
              timeToDisplay = "00:0" + min.toString() + ":" + sec.toString();
            }
            if (min <= 9 && sec <= 9) {
              timeToDisplay = "00:0" + min.toString() + ":0" + sec.toString();
            }
          }
          if (SetsTime > 3600) {
            int h = SetsTime ~/ 3600;
            int t = SetsTime - (3600 * h);
            int m = t ~/ 60;
            int s = t - (60 * m);
            if (h <= 9 && m > 9 && s > 9) {
              timeToDisplay =
                  "0" + h.toString() + ":" + m.toString() + ":" + s.toString();
            }
            if (h <= 9 && m > 9 && s <= 9) {
              timeToDisplay =
                  "0" + h.toString() + ":" + m.toString() + ":0" + s.toString();
            }
            if (h <= 9 && m <= 9 && s > 9) {
              timeToDisplay =
                  "0" + h.toString() + ":0" + m.toString() + ":" + s.toString();
            }
            if (h <= 9 && m <= 9 && s <= 9) {
              timeToDisplay = "0" +
                  h.toString() +
                  ":0" +
                  m.toString() +
                  ":0" +
                  s.toString();
            }

            if (h > 9 && m > 9 && s > 9) {
              timeToDisplay =
                  h.toString() + ":" + m.toString() + ":" + s.toString();
            }
            if (h > 9 && m > 9 && s <= 9) {
              timeToDisplay =
                  h.toString() + ":" + m.toString() + ":0" + s.toString();
            }
            if (h > 9 && m <= 9 && s > 9) {
              timeToDisplay =
                  h.toString() + ":0" + m.toString() + ":" + s.toString();
            }
            if (h > 9 && m <= 9 && s <= 9) {
              timeToDisplay =
                  h.toString() + ":0" + m.toString() + ":0" + s.toString();
            }
          }
        } else if (SetsTime < 60) {
          SetsTime = SetsTime - 1;
          timeToResume = SetsTime;
          timeToDisplay = "00:00:" + SetsTime.toString();
          if (SetsTime < 10) {
            timeToDisplay = "00:00:0" + SetsTime.toString();
          }
        } else if (SetsTime < 3600) {
          int m = SetsTime ~/ 60;
          int s = SetsTime - (60 * m);
          SetsTime = SetsTime - 1;
          timeToResume = SetsTime;
          if (m > 9 && s <= 9) {
            timeToDisplay = "00:" + m.toString() + ":0" + s.toString();
          }
          if (m > 9 && s > 9) {
            timeToDisplay = "00:" + m.toString() + ":" + s.toString();
          }
          if (m <= 9 && s <= 9) {
            timeToDisplay = "00:0" + m.toString() + ":0" + s.toString();
          }
          if (m <= 9 && s > 9) {
            timeToDisplay = "00:0" + m.toString() + ":" + s.toString();
          }
        } else {
          int h = SetsTime ~/ 3600;
          int t = SetsTime - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          SetsTime = SetsTime - 1;
          timeToResume = SetsTime;
          if (h <= 9 && m > 9 && s > 9) {
            timeToDisplay =
                "0" + h.toString() + ":" + m.toString() + ":" + s.toString();
          }
          if (h <= 9 && m > 9 && s <= 9) {
            timeToDisplay =
                "0" + h.toString() + ":" + m.toString() + ":0" + s.toString();
          }
          if (h <= 9 && m <= 9 && s > 9) {
            timeToDisplay =
                "0" + h.toString() + ":0" + m.toString() + ":" + s.toString();
          }
          if (h <= 9 && m <= 9 && s <= 9) {
            timeToDisplay =
                "0" + h.toString() + ":0" + m.toString() + ":0" + s.toString();
          }

          if (h > 9 && m > 9 && s > 9) {
            timeToDisplay =
                h.toString() + ":" + m.toString() + ":" + s.toString();
          }
          if (h > 9 && m > 9 && s <= 9) {
            timeToDisplay =
                h.toString() + ":" + m.toString() + ":0" + s.toString();
          }
          if (h > 9 && m <= 9 && s > 9) {
            timeToDisplay =
                h.toString() + ":0" + m.toString() + ":" + s.toString();
          }
          if (h > 9 && m <= 9 && s <= 9) {
            timeToDisplay =
                h.toString() + ":0" + m.toString() + ":0" + s.toString();
          }
        }
      });
    });
  }

  void stop() {
    setState(() {
      started = true;
      stopped = true;
      checkTimer = false;
    });
  }

  void resume() {
    setState(() {
      started = false;
      stopped = false;
    });
    SetsTime = timeToResume;
    Timer.periodic(
        Duration(
          seconds: 1,
        ), (Timer t) {
      setState(() {
        if (SetsTime < 1 || checkTimer == false) {
          t.cancel();
          checkTimer = true;
          started = true;
          stopped = true;
          // Output after stop
          if (SetsTime < 60) {
            timeToDisplay = "00:00:" + SetsTime.toString();
          }
          if (SetsTime < 10) {
            timeToDisplay = "00:00:0" + SetsTime.toString();
          }
          if (SetsTime < 3600) {
            int min;
            int sec;
            min = SetsTime ~/ 60;
            sec = SetsTime - (min * 60);
            timeToDisplay = "00:" + min.toString() + ":" + sec.toString();
            if (min > 9 && sec > 9) {
              timeToDisplay = "00:" + min.toString() + ":" + sec.toString();
            }
            if (min > 9 && sec <= 9) {
              timeToDisplay = "00:" + min.toString() + ":0" + sec.toString();
            }
            if (min <= 9 && sec > 9) {
              timeToDisplay = "00:0" + min.toString() + ":" + sec.toString();
            }
            if (min <= 9 && sec <= 9) {
              timeToDisplay = "00:0" + min.toString() + ":0" + sec.toString();
            }
          }
          if (SetsTime > 3600) {
            int h = SetsTime ~/ 3600;
            int t = SetsTime - (3600 * h);
            int m = t ~/ 60;
            int s = t - (60 * m);
            if (h <= 9 && m > 9 && s > 9) {
              timeToDisplay =
                  "0" + h.toString() + ":" + m.toString() + ":" + s.toString();
            }
            if (h <= 9 && m > 9 && s <= 9) {
              timeToDisplay =
                  "0" + h.toString() + ":" + m.toString() + ":0" + s.toString();
            }
            if (h <= 9 && m <= 9 && s > 9) {
              timeToDisplay =
                  "0" + h.toString() + ":0" + m.toString() + ":" + s.toString();
            }
            if (h <= 9 && m <= 9 && s <= 9) {
              timeToDisplay = "0" +
                  h.toString() +
                  ":0" +
                  m.toString() +
                  ":0" +
                  s.toString();
            }

            if (h > 9 && m > 9 && s > 9) {
              timeToDisplay =
                  h.toString() + ":" + m.toString() + ":" + s.toString();
            }
            if (h > 9 && m > 9 && s <= 9) {
              timeToDisplay =
                  h.toString() + ":" + m.toString() + ":0" + s.toString();
            }
            if (h > 9 && m <= 9 && s > 9) {
              timeToDisplay =
                  h.toString() + ":0" + m.toString() + ":" + s.toString();
            }
            if (h > 9 && m <= 9 && s <= 9) {
              timeToDisplay =
                  h.toString() + ":0" + m.toString() + ":0" + s.toString();
            }
          }
        } else if (SetsTime < 60) {
          SetsTime = SetsTime - 1;
          timeToResume = SetsTime;
          timeToDisplay = "00:00:" + SetsTime.toString();
          if (SetsTime < 10) {
            timeToDisplay = "00:00:0" + SetsTime.toString();
          }
        } else if (SetsTime < 3600) {
          int m = SetsTime ~/ 60;
          int s = SetsTime - (60 * m);
          SetsTime = SetsTime - 1;
          timeToResume = SetsTime;
          if (m > 9 && s <= 9) {
            timeToDisplay = "00:" + m.toString() + ":0" + s.toString();
          }
          if (m > 9 && s > 9) {
            timeToDisplay = "00:" + m.toString() + ":" + s.toString();
          }
          if (m <= 9 && s <= 9) {
            timeToDisplay = "00:0" + m.toString() + ":0" + s.toString();
          }
          if (m <= 9 && s > 9) {
            timeToDisplay = "00:0" + m.toString() + ":" + s.toString();
          }
        } else {
          int h = SetsTime ~/ 3600;
          int t = SetsTime - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          SetsTime = SetsTime - 1;
          timeToResume = SetsTime;
          if (h <= 9 && m > 9 && s > 9) {
            timeToDisplay =
                "0" + h.toString() + ":" + m.toString() + ":" + s.toString();
          }
          if (h <= 9 && m > 9 && s <= 9) {
            timeToDisplay =
                "0" + h.toString() + ":" + m.toString() + ":0" + s.toString();
          }
          if (h <= 9 && m <= 9 && s > 9) {
            timeToDisplay =
                "0" + h.toString() + ":0" + m.toString() + ":" + s.toString();
          }
          if (h <= 9 && m <= 9 && s <= 9) {
            timeToDisplay =
                "0" + h.toString() + ":0" + m.toString() + ":0" + s.toString();
          }

          if (h > 9 && m > 9 && s > 9) {
            timeToDisplay =
                h.toString() + ":" + m.toString() + ":" + s.toString();
          }
          if (h > 9 && m > 9 && s <= 9) {
            timeToDisplay =
                h.toString() + ":" + m.toString() + ":0" + s.toString();
          }
          if (h > 9 && m <= 9 && s > 9) {
            timeToDisplay =
                h.toString() + ":0" + m.toString() + ":" + s.toString();
          }
          if (h > 9 && m <= 9 && s <= 9) {
            timeToDisplay =
                h.toString() + ":0" + m.toString() + ":0" + s.toString();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 10.0,
                            ),
                            child: Text("Godziny"),
                          ),
                          NumberPicker.integer(
                              initialValue: hour,
                              minValue: 0,
                              maxValue: 23,
                              listViewWidth: 60.0,
                              onChanged: (val) {
                                setState(() {
                                  hour = val;
                                });
                              })
                        ]),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 10.0,
                            ),
                            child: Text("Minuty"),
                          ),
                          NumberPicker.integer(
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
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 10.0,
                            ),
                            child: Text("Sekundy"),
                          ),
                          NumberPicker.integer(
                              initialValue: sec,
                              minValue: 0,
                              maxValue: 59,
                              listViewWidth: 60.0,
                              onChanged: (val) {
                                setState(() {
                                  sec = val;
                                });
                              })
                        ]),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  timeToDisplay,
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: stopped ? resume : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 10.0,
                      ),
                      color: Colors.lightBlue,
                      child: Text(
                        "Wznów",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: started ? start : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 10.0,
                      ),
                      color: Colors.green,
                      child: Text(
                        "Start",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    RaisedButton(
                      onPressed: stopped ? null : stop,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 10.0,
                      ),
                      color: Colors.red,
                      child: Text(
                        "Stop",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ],
                ),
              ),
            ]));
  }

}