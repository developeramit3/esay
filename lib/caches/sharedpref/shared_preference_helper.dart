import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

class SharedPreferenceHelper {
  Future<SharedPreferences> _sharedPreference;

  static const String language_code = "language_code";

  SharedPreferenceHelper() {
    _sharedPreference = SharedPreferences.getInstance();
  }
/*==================================AppLocale============================================*/
  Future<String> get appLocale {
    return _sharedPreference.then((prefs) {
      return prefs.getString(language_code) ?? null;
    });
  }

  Future<void> changeLanguage(String value) {
    return _sharedPreference.then((prefs) {
      return prefs.setString(language_code, value);
    });
  }
/*===================================User===========================================*/

  Future<UserModel> getUserPref() {
    return _sharedPreference.then((prefs) {
      return UserModel(
          phoneNumber: prefs.getString("phoneNumber"),
          tokenId: prefs.getString("tokenId"));
    });
  }

  Future<void> setUserPref(UserModel userModel) {
    return _sharedPreference.then((prefs) {
      prefs.setString("phoneNumber", userModel.phoneNumber);
      prefs.setString("tokenId", userModel.tokenId);
    });
  }

  /*==================================StateWelcomeScreen============================================*/
  Future<bool> get getStateWelcomeScreen {
    return _sharedPreference.then((prefs) {
      return prefs.getBool('checkWelcomeScreen') == null
          ? false
          : prefs.getBool('checkWelcomeScreen');
    });
  }

  Future<bool> setStateWelcomeScreen(bool value) {
    return _sharedPreference.then((prefs) {
      return prefs.setBool('checkWelcomeScreen', value);
    });
  }

/*==================================favorite=======================================================*/
  Future<List<String>> getFavoriteIdsPrefs() {
    return _sharedPreference.then((prefs) {
      return prefs.getStringList("favoriteIds") == null
          ? []
          : prefs.getStringList("favoriteIds");
    });
  }

  Future<void> setFavoriteIdsPrefs(String offerId) {
    return _sharedPreference.then((prefs) {
      List<String> favoriteIds = prefs.getStringList("favoriteIds") == null
          ? []
          : prefs.getStringList("favoriteIds");
      favoriteIds.add(offerId);
      prefs.setStringList("favoriteIds", favoriteIds);
    });
  }

  Future<void> removeFavoriteIdPrefs(String offerId) {
    return _sharedPreference.then((prefs) {
      List<String> favoriteIds = prefs.getStringList("favoriteIds") == null
          ? []
          : prefs.getStringList("favoriteIds");
      favoriteIds.remove(offerId);
      prefs.setStringList("favoriteIds", favoriteIds);
    });
  }
  /*===================================Rate===========================================*/

  Future<bool> getRate() {
    return _sharedPreference.then((prefs) {
      return prefs.getBool("rate") == null ? false : prefs.getBool("rate");
    });
  }

  Future<void> setRate() {
    return _sharedPreference.then((prefs) {
      prefs.setBool("rate", true);
    });
  }

  /*===================================Code===========================================*/
  Future<List<String>> getCodesPrefs() {
    return _sharedPreference.then((prefs) {
      return prefs.getStringList("codes") == null
          ? []
          : prefs.getStringList("codes");
    });
  }

  Future<void> removeCodesPrefs(String code) {
    return _sharedPreference.then((prefs) {
      List<String> codes = prefs.getStringList("codes") == null
          ? []
          : prefs.getStringList("codes");
      if (codes.contains(code)) {
        codes.remove(code);
      }
      prefs.setStringList("codes", codes);
    });
  }

  Future<void> setCodesPrefs(String code) {
    return _sharedPreference.then((prefs) {
      List<String> codes = prefs.getStringList("codes") == null
          ? []
          : prefs.getStringList("codes");
      codes.add(code);
      prefs.setStringList("codes", codes);
    });
  }

/*===================================Store===========================================*/
  Future<String> getStorePrefs() {
    return _sharedPreference.then((prefs) {
      return prefs.getString("store") == null ? "" : prefs.getString("store");
    });
  }

  Future<void> setStorePrefs(String store) {
    return _sharedPreference.then((prefs) {
      prefs.setString("store", store);
    });
  }

  Future<void> removeStorePrefs() {
    return _sharedPreference.then((prefs) {
      return prefs.remove("store");
    });
  }
}
