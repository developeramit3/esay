class FirestorePath {
  static String users(String uid) => 'users/$uid';
  static String checkUser() => 'users';
  static String offers() => 'offers';
  static String offersSecret() => 'offer_secret';
  static String offersCategory() => 'offers_category';
  static String stores() => 'stores';
  static String storeDetails(String offerId) => 'offers/$offerId/details';
  static String storeDetailsSecret(String offerId) =>
      'offer_secret/$offerId/details';
  static String offersCodes(String offerId) => 'offers/$offerId/codes';
  static String setCodes(String id) => 'codes/$id';
  static String getCodes() => 'codes';
  static String sharingUsers(String uid) => 'sharing_users/$uid';
  static String checkSharingUsers() => 'sharing_users';
}
