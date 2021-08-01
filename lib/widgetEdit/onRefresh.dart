
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';

import 'codeQ.dart';

class OnRefresh {
  static Future <void> onRef(context , var controller ,  Function function ,  ConfettiController controllerTopCenter) async{
    print(";;;");
     await FirebaseFirestore.instance.collection('tools')
        .doc('8ClVk2443dfOUbHrJWUz')
        .get().then((value) {

        return showQDialog(context,value['the_question'],value['answer'],controller,function ,controllerTopCenter);
    });
  }
}
