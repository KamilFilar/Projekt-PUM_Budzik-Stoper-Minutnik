import 'dart:async';
import 'package:flutter/material.dart';


class Stoper extends StatefulWidget {
  final List<String> x;
  Stoper(this.x);
  @override
  _Stoper createState() => _Stoper();
}

class _Stoper extends State<Stoper> {
  @override
  void initState() {
    super.initState();
  }

  bool start2 = true;
  bool stop2 = true;
  bool reset2 = true;
  bool savetime = true;
  String StoperTime = "00:00:00";
  int SaveTime = 0;
  String SaveTimeString = "00:00:00";
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);

  void keepruning() {
    if (swatch.isRunning) {
      starttimer();
    }
    setState(() {
      StoperTime = swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
      //Wypisać milisekundy!!
      //+ (swatch.elapsed.inMilliseconds%1000).toString().padLeft(2,"0");
    });
  }

  void starttimer() {
    Timer(dur, keepruning);
  }

  void startStoper() {
    setState(() {
      stop2 = false;
      reset2 = true;
    });
    swatch.start();
    starttimer();
  }

  void stopStoper() {
    setState(() {
      stop2 = true;
      reset2 = false;
    });
    swatch.stop();
  }

  void resetStoper() {
    setState(() {
      stop2 = false;
      reset2 = true;
    });
    StoperTime = "00:00:00";
    for(int i=0;i<5;i++){
      widget.x[i] = null;
    }
    swatch.reset();
  }

  void showStop() {
    setState(() {
      stop2 = false;
      reset2 = true;
    });
    SaveTimeString = swatch.elapsed.inHours.toString().padLeft(2, "0") +
        ":" +
        (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
        ":" +
        (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");

    print(SaveTimeString);
  }
  // List<String> x =  List<String>();

  showPartTime() {
    widget.x[4] = widget.x[3];

    widget.x[3] = widget.x[2];

    widget.x[2] = widget.x[1];

    widget.x[1] = widget.x[0];

    widget.x[0] = swatch.elapsed.inHours.toString().padLeft(2, "0") +
        ":" +
        (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
        ":" +
        (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    print(widget.x[0]);
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.shade900,
        child: Column(
          children: [
            Expanded(
              child: Column(children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top:80.0),
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          StoperTime,
                          style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.lightGreenAccent.shade700
                          ),
                        )),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: List.generate(
                                  5,
                                      (index) => Text(
                                    (widget.x.elementAt(index) == null ||
                                        widget.x.elementAt(index) == ""
                                        ? ""
                                        : (index+1).toString()+" - "+widget.x.elementAt(index)),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white
                                    ),
                                  )),
                            )),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  RaisedButton(
                                    onPressed: stop2 ? null : showPartTime,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                                    padding: EdgeInsets.all(3.0),
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
                                        constraints: BoxConstraints(minWidth: 100, maxHeight: 45.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Pomiar",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  RaisedButton(
                                    onPressed: stop2 ? null : stopStoper,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                                    padding: EdgeInsets.all(2.0),
                                    color: Colors.red,
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [Colors.grey.shade900,
                                          Colors.red.shade900,],
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
                                        constraints: BoxConstraints(minWidth: 100, maxHeight: 45.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Stop",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  RaisedButton(
                                    onPressed: reset2 ? null : resetStoper,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                                    padding: EdgeInsets.all(3.0),
                                    color: Colors.red,
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [Colors.grey.shade900,
                                          Colors.red.shade900,],
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
                                        constraints: BoxConstraints(minWidth: 100, maxHeight: 45.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Reset",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  RaisedButton(
                                    onPressed: startStoper,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                                    padding: EdgeInsets.all(3.0),
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
                                        constraints: BoxConstraints(minWidth: 200, maxHeight: 50.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Start",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ]),
            ),
          ],
        ));
  }
}
