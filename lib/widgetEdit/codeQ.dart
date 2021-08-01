import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:esay/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../app_localizations.dart';
import 'package:qr_flutter/qr_flutter.dart';

showQDialog(
    BuildContext context,
    String q,
    an,
    TextEditingController _contoller,
    Function function,
    ConfettiController controllerTopCenter) async {
  print('pi$pi');
  return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          insetPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Container(
            height: 300,
            child: Stack(
              overflow: Overflow.visible,
              alignment: Alignment.topCenter,
              children: [
                buildConfettiWidget(controllerTopCenter, pi / 1),
                buildConfettiWidget(controllerTopCenter, pi / 4),
                Container(
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 40, 30, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        Container(
                            height: 40,
                            child: Text(
                              q,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: _contoller,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'رجاء ادخل الجواب',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Container(
                            width: 120,
                            child: RaisedButton(
                              onPressed: () async {
                                if (_contoller.text.trim() == an) {
                                  controllerTopCenter.play();
                                  Future.delayed(Duration(seconds: 5),
                                      () async {
                                    controllerTopCenter.stop();
                                    Navigator.pop(context);
                                    await function();
                                  });
                                  _contoller.clear();
                                } else {
                                  showT(context);
                                  _contoller.clear();
                                }
                              },
                              child: Text(
                                'تحقاق',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              color: HexColor('#2c6bec'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: -65,
                    child: Image.asset(
                      "assets/images/celebrating emoji.png",
                      width: 100,
                    )),
              ],
            ),
          )));
}

Align buildConfettiWidget(controller, double blastDirection) {
  return Align(
    alignment: Alignment.topCenter,
    child: ConfettiWidget(
      maximumSize: Size(30, 30),
      shouldLoop: false,
      confettiController: controller,
      blastDirection: blastDirection,
      blastDirectionality: BlastDirectionality.directional,
      maxBlastForce: 20, // set a lower max blast force
      minBlastForce: 8, // set a lower min blast force
      emissionFrequency: 1,
      numberOfParticles: 8, // a lot of particles at once
      gravity: 1,
    ),
  );
}
