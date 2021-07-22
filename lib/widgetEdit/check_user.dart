// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import 'custdelog.dart';
// import 'package:esay/providers/auth_provider.dart';
//
//
// class CheckNot {
//
//   static void checkMode(context) {
//     int index = 1;
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     print(authProvider.userModel.phoneNumber);
//     var res = FirebaseFirestore.instance.collection("users").where("").get();
//        FirebaseFirestore.instance
//         .collection("tools").doc().get().then((value) {
//       if (value[0][''] == true) {
//         res.then((valueUser) {
//           if ( valueUser.docs[index]['subscription1'] == true &&
//               valueUser['subscription12'] == true &&
//               valueUser['subscription6'] == true) {
//             print("you already have sub ");
//           }
//         });
//       }else {
//         print("test mode");
//       }
//     });
//   }
// }