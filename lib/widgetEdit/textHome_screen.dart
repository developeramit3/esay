import 'package:flutter/material.dart';
import 'package:esay/services/class_stream.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay/ui/account/account_screen.dart';

Widget textSub() {
  FirebaseFirestore.instance.collection("tools").doc().get().then((value) {
   return  Container(
     height: 30,
     child: Container(
       alignment: Alignment.center,
       height: 40,
       width: double.infinity,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Text(
             value[0]["title_free"],
             style: TextStyle(
               color: Color(0xff2c6bec),
               fontSize: 20,
             ),
           ),
         ],
       ),
     ),
   );
 });
}

Widget getText() {
  return Align(
      alignment: Alignment.center,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("tools").snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapShout) {
          if (snapShout.hasError) return new Text('Error: ${snapShout.error}');
          switch (snapShout.connectionState) {
            case ConnectionState.waiting:
              return new Center(
                child: CircularProgressIndicator(),
              );
            default:
              return Container(
                height: 30,
                child: ListView.builder(
                    itemCount: snapShout.data.docs.length,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        if (snapShout.data.docs[0]["active_mode"] != true) Text(
                        snapShout.data.docs[0]["title_free"],
                              style: TextStyle(
                                color: Color(0xff2c6bec),
                                fontSize: 20,
                              ),
                            ) else Row(
                              children: [
                                Text('لديك 3 رموز مجاني . للحصول على المزيد',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w900),),
                              SizedBox(width: 5,),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=>AccountScreen()));
                                  },
                                  child: Text('اشترك الان',
                                    style: TextStyle(color: Color(0xff2c6bec),fontWeight: FontWeight.bold,fontSize: 18, decoration: TextDecoration.underline
                                    , decorationColor: Colors.blue,
                                      decorationThickness: 2,
                                    ),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              );
          }
        },
      ));
}
