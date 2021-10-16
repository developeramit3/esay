import 'package:esay/progress/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loadingPage(BuildContext context) {
  return CircularProgressIndicator(
      backgroundColor: Theme.of(context).iconTheme.color);
}

Widget loadingBtn(BuildContext context) {
  return Container(
    width: 150,
    child: SpinKitRotatingCircle(
      color: Colors.white,
      size: 30.0,
    ),
  );
}

loadingDialog(BuildContext context) {
  return showProgressDialog(context: context);

  // return showDialog(
  //   context: context,
  //   barrierDismissible: false,
  //   builder: (BuildContext context) {
  //     return Dialog(
  //       child: Container(
  //         height: 80,
  //         width: 100,
  //         child: Row(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [CircularProgressIndicator()],
  //         ),
  //       ),
  //     );
  //   },
  //);
}
