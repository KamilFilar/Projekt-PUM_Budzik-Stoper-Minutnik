import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


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


  String StoperTime = "00:00:00";
  String SaveTimeString = "00:00:00";

  var swatch = Stopwatch();
  final dur = const Duration(milliseconds: 1);

  void keepruning() {
    if (swatch.isRunning) {
      starttimer();
    }
    if (this.mounted){
    setState(() {
      StoperTime = swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0")+
          ":" +
          (swatch.elapsed.inMilliseconds % 100).toString().padLeft(2, "0");
    });
    }
  }

  void starttimer() {
    Timer(dur, keepruning);
  }


  bool start2 = true;
  bool stop2 = true;
  bool reset2 = true;
  bool savetime = true;
  bool isButtonBlocked=false;
  bool isrunning = false;

  void startStoper() {
    isrunning = true;
    if (this.mounted){
      setState(() {
        stop2 = false;
        reset2 = true;
      });
    }
    swatch.start();
    starttimer();
  }

  void stopStoper() {
    isrunning = false;
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
    isButtonBlocked=false;
    for(int i=0;i<10;i++){
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
        (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0")+
        ":" +
        (swatch.elapsed.inMilliseconds % 100).toString().padLeft(2, "0");

    print(SaveTimeString);
  }
  // List<String> x =  List<String>();

  showPartTime() {
    widget.x[9] = widget.x[8];
    widget.x[8] = widget.x[7];
    widget.x[7] = widget.x[6];
    widget.x[6] = widget.x[5];
    widget.x[5] = widget.x[4];
    widget.x[4] = widget.x[3];

    widget.x[3] = widget.x[2];

    widget.x[2] = widget.x[1];

    widget.x[1] = widget.x[0];

    widget.x[0] = swatch.elapsed.inHours.toString().padLeft(2, "0") +
        ":" +
        (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
        ":" +
        (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0")+
        ":" +
        (swatch.elapsed.inMilliseconds % 100).toString().padLeft(2, "0");

    print("Pomiar: "+widget.x[0]);

    if(widget.x[9]!=null) isButtonBlocked=true;
    setState(() {});

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                    padding: const EdgeInsets.only(top:50.0),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 25, left: 25, right: 25),
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
                              spreadRadius: 1,
                              offset: Offset(4, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.all((Radius.circular(30))),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          StoperTime,
                          style: GoogleFonts.comicNeue(
                            fontWeight: FontWeight.w900,
                            color: Colors.lightGreenAccent.shade700,
                            fontSize: 50,
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
                          margin: EdgeInsets.only(bottom: 25, left: 60, right: 60),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.lightGreenAccent.shade700,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                ),
                              ],
                              borderRadius: BorderRadius.all((Radius.circular(30))),
                            ),
                            alignment: Alignment.topCenter,
                              child: new ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                Column(
                                  children: List.generate(
                                    10,
                                        (index) => Text(
                                      (widget.x.elementAt(index) == null ||
                                          widget.x.elementAt(index) == ""
                                          ? "Pomiar "+(index+1).toString()+'\n'+"-----------------------"
                                          : "t"+(10-index).toString()+" - "+widget.x.elementAt(index)+'\n'+"-----------------------"),
                                          textAlign: TextAlign.center,

                                          style: GoogleFonts.comicNeue(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                    ),
                                  ),
                                )
                              ],
                              )
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  RaisedButton(
                                    onPressed: (){isrunning ? {isButtonBlocked ? print("Osiągnięto limit pomiarów!")
                                        :{stop2 ? null : showPartTime()}} : print("Stoper nie pracuje!"); },
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                                    padding: EdgeInsets.all(3.0),
                                    color: isButtonBlocked ? Colors.black : Colors.green.shade900,
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
                                        constraints: BoxConstraints(minWidth: 130, maxHeight: 45.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Pomiar",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.comicNeue(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 25,
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
                                        constraints: BoxConstraints(minWidth: 130, maxHeight: 45.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Stop",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.comicNeue(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 25,
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
                                        constraints: BoxConstraints(minWidth: 130, maxHeight: 45.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Reset",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.comicNeue(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 25,
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
                                    onPressed: (){isrunning ? print("Stoper jest uruchomiony!"): startStoper();},
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                                    padding: EdgeInsets.all(3.0),
                                    color: isrunning ? Colors.black : Colors.green.shade900,
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
                                          style: GoogleFonts.comicNeue(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 30,
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
