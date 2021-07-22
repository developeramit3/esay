import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<void> openFile(BuildContext context, String url, String fileName) async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = new File('$dir/$fileName');
  var request = await http.get(url);
  await file.writeAsBytes(request.bodyBytes);
  await OpenFile.open(file.path);
}
