import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> favoriteIds = [];

  List<String> get getFavoriteId => favoriteIds;

  void addFavoriteIdsValue(List<String> favoriteIdsPrefs) {
    favoriteIds = favoriteIdsPrefs;
    notifyListeners();
  }

  void changeFavoriteIdsValue(String favoriteId) {
    favoriteIds.add(favoriteId);
    notifyListeners();
  }

  void removeFavoriteIdValue(String favoriteId) {
    favoriteIds.remove(favoriteId);
    notifyListeners();
    print(favoriteIds);
  }
}
