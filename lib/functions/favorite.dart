import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../caches/sharedpref/shared_preference_helper.dart';
import '../providers/favorite_provider.dart';
import '../services/firestore_database.dart';

/*================================favorite=====================================*/

void getFavoritesId(BuildContext context) async {
  final favoriteProvider =
      Provider.of<FavoriteProvider>(context, listen: false);
  List<String> favoriteIds =
      await SharedPreferenceHelper().getFavoriteIdsPrefs();
  favoriteProvider.addFavoriteIdsValue(favoriteIds);
}

void favoriteLike(BuildContext context, String offerId) async {
  final favoriteProvider =
      Provider.of<FavoriteProvider>(context, listen: false);
  final firestoreDatabase =
      Provider.of<FirestoreDatabase>(context, listen: false);
  favoriteProvider.changeFavoriteIdsValue(offerId);
  SharedPreferenceHelper().setFavoriteIdsPrefs(offerId);
  await firestoreDatabase.updateFavoriteBtn(false, offerId);
}

void favoriteUnLike(BuildContext context, String offerId) async {
  final favoriteProvider =
      Provider.of<FavoriteProvider>(context, listen: false);
  final firestoreDatabase =
      Provider.of<FirestoreDatabase>(context, listen: false);
  favoriteProvider.removeFavoriteIdValue(offerId);
  SharedPreferenceHelper().removeFavoriteIdPrefs(offerId);
  await firestoreDatabase.updateFavoriteBtn(true, offerId);

}
/*================================favorite=====================================*/
