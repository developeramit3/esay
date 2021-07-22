import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

Future<void> share(
    String url, String fileName, String storeName, String description) async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = new File('$dir/$fileName');
  var request = await http.get(url);
  await file.writeAsBytes(request.bodyBytes);
  String message = "$storeName عاملين $description على تطبيق إيزي";
  Share.shareFiles(['${file.path}'], text: message, subject: message);
}
