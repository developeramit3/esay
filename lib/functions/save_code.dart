import 'package:esay/caches/sharedpref/shared_preference_helper.dart';
import 'package:esay/models/code_model.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

final LocalStorage storageCodes = LocalStorage('codes');
final CodeModelList list = CodeModelList();

addCode(
    BuildContext context, String code, String storeName, String endDateTime) {
  CodeModel codeModel = CodeModel(
    code: code,
    storeName: storeName,
    endDateTime: endDateTime,
  );
  list.items.clear();
  list.items.add(codeModel);
  storageCodes.setItem(
    code,
    list.toJSONEncodable(),
  );
  SharedPreferenceHelper().setCodesPrefs(code);
}
