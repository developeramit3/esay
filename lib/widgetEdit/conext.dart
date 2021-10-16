import 'dart:io';
import 'package:esay/providers/account_provider.dart';
import 'package:provider/provider.dart';
class Connect{
  static Future<void> connect( context )async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
          Provider.of<AccountProvider>(context,listen: false).checkConnect(true);
         bool c =  Provider.of<AccountProvider>(context,listen: false).connect;
        print('connected$c');
      }
    } on SocketException catch (_) {
      Provider.of<AccountProvider>(context,listen: false).checkConnect(false);
    }
  }
}