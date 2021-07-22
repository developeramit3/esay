import 'package:flutter/material.dart';

import '../caches/sharedpref/shared_preference_helper.dart';

class LanguageProvider extends ChangeNotifier {
  SharedPreferenceHelper _sharedPrefsHelper;

  Locale _appLocale = Locale('ar');

  LanguageProvider() {
    _sharedPrefsHelper = SharedPreferenceHelper();
  }

  Locale get appLocale {
    _sharedPrefsHelper.appLocale.then((localeValue) {
      if (localeValue != null) {
        _appLocale = Locale(localeValue);
      }
    });

    return _appLocale;
  }

  void updateLanguage(String languageCode) {
    if (languageCode == "ar") {
      _appLocale = Locale("ar");
    } else {
      _appLocale = Locale("en");
    }

    _sharedPrefsHelper.changeLanguage(languageCode);
    notifyListeners();
  }
}
