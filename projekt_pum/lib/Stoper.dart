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
                                    color: Colors.red,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40.0,
                                      vertical: 15.0,
                                    ),
                                    child: Text(
                                      "Pomiar",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
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
                                    color: Colors.red,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40.0,
                                      vertical: 15.0,
                                    ),
                                    child: Text(
                                      "Stop",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  RaisedButton(
                                    onPressed: reset2 ? null : resetStoper,
                                    color: Colors.green,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40.0,
                                      vertical: 15.0,
                                    ),
                                    child: Text(
                                      "Reset",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
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
                                    color: Colors.blue,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 80.0,
                                      vertical: 20.0,
                                    ),
                                    child: Text(
                                      "Start",
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        color: Colors.white,
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
